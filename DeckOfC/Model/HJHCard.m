//
//  HJHCard.m
//  DeckOfC
//
//  Created by Hannah Hoff on 3/26/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

#import "HJHCard.h"

@implementation HJHCard

-(instancetype)initWithSuit:(NSString *)suit imageUrl:(NSString *)imageUrl
{
    self = [super init];
    if (self) {
        
        _suit = suit;
        _imageUrl = imageUrl;
    }
    return self;
}

@end

@implementation HJHCard (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suitFromDictionary = dictionary[@"suit"];
    NSString *imageUrlFromDictionary = dictionary[@"imageUrl"];
    
    if(![suitFromDictionary isKindOfClass:[NSString class]] || ![imageUrlFromDictionary isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [self initWithSuit:suitFromDictionary imageUrl:imageUrlFromDictionary];
}

@end
