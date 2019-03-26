//
//  HJHCardController.h
//  DeckOfC
//
//  Created by Hannah Hoff on 3/26/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HJHCard;

NS_ASSUME_NONNULL_BEGIN

@interface HJHCardController : NSObject
// singleton
+ (instancetype)shared;


-(void)drawNewCard:(NSInteger)numberOfCards completion:(void(^) (NSArray<HJHCard *> *cards, NSError *error))completion;
-(void)fetchCardImage:(HJHCard *)card completion:(void(^) (UIImage *image, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
