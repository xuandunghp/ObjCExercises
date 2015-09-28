//
//  NSArray+Extend.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/28/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)

- (NSDictionary *) countElements {
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    for (id obj in self) {
        if (result[obj] == nil) {
            result[obj] = @1;
        }
        else {
            result[obj] = [NSNumber numberWithInt:[result[obj] intValue] + 1];
        }
    }
    
    return result;
}

@end
