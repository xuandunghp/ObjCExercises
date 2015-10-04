//
//  HexColor.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "HexColor.h"

@implementation HexColor

+ (instancetype) colorWithHex:(NSString *)hex alpha:(CGFloat)alpha {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\\da-fA-F]{6}$"];
    
    if ([predicate evaluateWithObject:hex]) {
        unsigned long long colorValue;
        NSScanner *scanner = [[NSScanner alloc] initWithString:hex];
        
        [scanner scanHexLongLong:&colorValue];
        
        CGFloat red = (CGFloat)((colorValue & 0xFF0000) >> 16) / 255.0;
        CGFloat green = (CGFloat)((colorValue & 0x00FF00) >> 8) / 255.0;
        CGFloat blue = (CGFloat)(colorValue & 0x0000FF) / 255.0;
        
        return (HexColor *)[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    else {
        return (HexColor *)[UIColor blackColor];
    }
}

@end
