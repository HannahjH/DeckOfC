//
//  HJHCard.h
//  DeckOfC
//
//  Created by Hannah Hoff on 3/26/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJHCard : NSObject

@property (nonatomic, copy, readonly)NSString *suit;
@property (nonatomic, copy, readonly)NSString *imageUrl;

- (instancetype)initWithSuit:(NSString *)suit imageUrl:(NSString *)imageUrl;

@end

@interface HJHCard (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
