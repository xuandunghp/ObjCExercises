//
//  Exercise2.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/28/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "Exercise2.h"

@interface Exercise2 ()

@end

@implementation Exercise2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    for (int i = 0; i < 10; i++) {
        [arr addObject:[self genRandStringWithMaxLength:5]];
    }
    
    for (NSString *str in arr) {
        [self write:str];
        [self write:@" "];
    }
    
    [self writeln:@"\n"];
    
    [self quickSort:arr];
    
    for (NSString *str in arr) {
        [self write:str];
        [self write:@" "];
    }
}

- (void) quickSort:(NSMutableArray *)arr {
    int length = (int)[arr count];
    if (length <= 1) return;
    
    NSMutableArray *lowerOrEqual = [NSMutableArray new];
    NSMutableArray *greater = [NSMutableArray new];

    int pivotIndex = arc4random_uniform(length);
    NSString *pivot = arr[pivotIndex];
    
    for (int i = 0; i < length; i++) {
        if (i == pivotIndex) continue;
        
        NSComparisonResult order = [arr[i] compare:pivot];
        
        if (order == NSOrderedAscending || order == NSOrderedSame ) {
            [lowerOrEqual addObject:arr[i]];
        }
        else {
            [greater addObject:arr[i]];
        }
    }

    [arr removeAllObjects];
    
    [self quickSort:lowerOrEqual];
    [self quickSort:greater];
    
    [arr addObjectsFromArray:lowerOrEqual];
    [arr addObject:pivot];
    [arr addObjectsFromArray:greater];
}

- (NSString *)genRandStringWithMaxLength:(int)maxLength {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    int length = arc4random_uniform(maxLength) + 1;
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];

    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }

    return randomString;
}

@end
