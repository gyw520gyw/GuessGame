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


//打乱备选区文字
- (void) randamOption {

    self.options = [self.options sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
      
        int seed = arc4random_uniform(2);
        
        if(seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str2];
        }
        
    }];
    
    NSLog(@"%@", self.options);
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {answer: %@ , icon: %@ , title: %@ , options: %@}", self.class, self, self.answer, self.icon, self.title, self.options];
}

@end
