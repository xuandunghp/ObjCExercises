//
//  DemoFunction.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/19/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "DemoFunction.h"

@implementation DemoFunction
- (void)viewDidLoad {
    [super viewDidLoad];
    [self writeln:@"Hello World"];
    
    [self sayFirstName:@"Steve" andLastName:@"Jobs"];
    
    float tempDegree = 30.0;
    NSString* result = [NSString stringWithFormat:@"%2.1f degree equal to %3.1f F",
                        tempDegree, [self celciusToFahrenheit:tempDegree]];
    [self writeln: result];
    [self celciusToFahrenheit];
    
    [self performSelector:@selector(celciusToFahrenheit)];
    [self performSelector:@selector(celciusToFahrenheit2:) withObject:@(30)];
    
}
- (void) sayFirstName: (NSString*) firstName andLastName: (NSString*) lastName {
    NSLog(@"%@ %@", firstName, lastName);
}
- (float) celciusToFahrenheit: (float) degree {
    return degree * 1.8 + 32.0;
}

- (void) celciusToFahrenheit {
    NSLog(@"Do nothing");
}

- (void) celciusToFahrenheit2: (NSNumber*) degree {
    float result =  [degree floatValue] * 1.8 + 32.0;
    NSLog(@"Result = %2.1f", result);
}

@end