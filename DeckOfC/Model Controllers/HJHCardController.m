//
//  HJHCardController.m
//  DeckOfC
//
//  Created by Hannah Hoff on 3/26/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

#import "HJHCardController.h"
#import "HJHCard.h"

@implementation HJHCardController

+ (instancetype)shared
{
    static HJHCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [HJHCardController new];
    });
    return shared;
}

-(void)drawNewCard:(void (^)(HJHCard *))completion
{
    
    NSURL *baseUrl = [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/new/draw"];
    NSString *cardCount = [@(1) stringValue];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseUrl resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    components.queryItems = @[queryItem];
    NSURL *searchUrl = components.URL;
    
    NSLog(@"%@", [searchUrl absoluteString]);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error: no data returned from task");
            completion(nil);
            return;
        }
        // NSJSONSerialization takes info from the web and makes it presentable to a user on a mobile device.
        // info meaning data which are small binary bits. The result is that it will initialize JSON into our Object! Woo!
        NSDictionary *jsonDictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:(&error)];
        NSArray *cardsArray = jsonDictionaries[@"cards"];
        NSDictionary *cardDictionary = cardsArray[0];
        
            HJHCard *card = [[HJHCard alloc] initWithDictionary:cardDictionary];
        
        completion(card);
    }] resume];
}

-(void)fetchCardImage:(HJHCard *)card completion:(void (^)(UIImage *, NSError *))completion
{
    NSURL *imageUrl = [NSURL URLWithString:card.imageUrl];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        if (!data) {
            NSLog(@"Error: no image data returned from task");
            return completion(nil, [NSError errorWithDomain:@"error Fetching Image Data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage, nil);
    }] resume];
}



@end
