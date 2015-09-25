//
//  NSArray+GettingUniqueElementsAddition.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/25/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "NSArray+GettingUniqueElementsAddition.h"

@implementation NSArray (GettingUniqueElementsAddition)

- (NSArray *) getUniqueElements {
    NSMutableArray *uniqueElements = [NSMutableArray new];
    
    for (NSObject *element in self) {
        bool duplicated = false;
        
        for (NSObject *addedElement in uniqueElements) {
            if ([element isEqual:addedElement]) {
                duplicated = true;
                break;
            }
        }
        
        if (!duplicated) {
            [uniqueElements addObject:element];
        }
    }
    
    return uniqueElements;
}

@end
