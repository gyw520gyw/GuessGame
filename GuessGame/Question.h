//
//  Question.h
//  GuessGame
//
//  Created by gyw on 16/9/26.
//  Copyright © 2016年 gyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property(nonatomic, strong) NSString *answer;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray *options;

- (instancetype)initWithDict:(NSDictionary *) dict;
+ (instancetype)questionWithDict:(NSDictionary *) dict;

+ (NSArray *)questions;

- (void)randamOption;

@end
