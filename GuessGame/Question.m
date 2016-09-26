//
//  Question.m
//  GuessGame
//
//  Created by gyw on 16/9/26.
//  Copyright © 2016年 gyw. All rights reserved.
//

#import "Question.h"

@implementation Question


- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)questionWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
    
}


+ (NSArray *)questions {
    
    NSMutableArray *mutablArr = [[NSMutableArray alloc] init];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil]];
    
    
    for (NSDictionary *dict in arr) {
        
        [mutablArr addObject:[self questionWithDict:dict]];
        
    }
    
    
    return mutablArr;

}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {answer: %@ , icon: %@ , title: %@ , options: %@}", self.class, self, self.answer, self.icon, self.title, self.options];
}

@end
