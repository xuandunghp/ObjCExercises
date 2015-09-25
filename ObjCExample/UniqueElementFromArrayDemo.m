//
//  UniqueElements.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/25/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "UniqueElementFromArrayDemo.h"
#import "NSArray+GettingUniqueElementsAddition.h"

@implementation UniqueElementFromArrayDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    for (int i = 0; i < 10; i++) {
        [arr addObject:[NSNumber numberWithInt:arc4random() % 5]];
    }
    
    NSArray *uniqueElements = [arr getUniqueElements];
    
    
    [self writeln:@"Input array:"];
    [self writeln:[NSString stringWithFormat:@"%@", arr]];
    [self writeln:@"Unique elements are:"];
    [self writeln:[NSString stringWithFormat:@"%@", uniqueElements]];
}

@end
