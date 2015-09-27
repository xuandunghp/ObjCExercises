//
//  IntegerToText.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/26/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "IntegerToText.h"


typedef enum {
    ONE = 1
} dic;


@implementation IntegerToText
{
    NSDictionary *_0To9, *_10To19, *_x10;
    NSArray *_group3Unit;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Number must be positive integers and can be in unlimited length
    NSArray *input = @[@1, @1000, @1000000, @1000000000, @"10000010010000001", @"12345678901234567890", @"12a", @"-123"];
    
    _0To9 = @{@"0": @"zero", @"1": @"one", @"2": @"two", @"3": @"three", @"4": @"four", @"5": @"five", @"6": @"six",
              @"7": @"seven", @"8": @"eight", @"9": @"nine"};

    _10To19 = @{@"10": @"tenth", @"11": @"eleven", @"12": @"twelve", @"13": @"thirdteen", @"14": @"fourteen",
                @"15": @"fifthteen", @"16": @"sixteen", @"17": @"seventeen", @"18": @"eighteen", @"19": @"nineteen"};

    _x10 = @{@"2": @"twenty", @"3": @"thirty", @"4": @"forty", @"5": @"fifty", @"6": @"sixty", @"7": @"seventy",
             @"8": @"eighty", @"9": @"ninety"};
    
    _group3Unit = @[@"thousand", @"million", @"billion"];

    
    [input enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [self writeln:[NSString stringWithFormat:@"%@ => %@", obj, [self getReadingFromNumberPresentation:obj]]];
        }
        else if ([obj respondsToSelector:@selector(stringValue)]) {
            [self writeln:[NSString stringWithFormat:@"%@ => %@", obj, [self getReadingFromNumberPresentation:[obj stringValue]]]];
        }
        [self writeln:@""];
    }];
}

- (NSString *) getReadingFromNumberPresentation:(NSString *)numberStr {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *matched = [regex firstMatchInString:numberStr options:0 range:NSMakeRange(0, [numberStr length])];
    
    if (matched != nil) return @"Not a positive integer";
    
    NSMutableString *result = [NSMutableString new];
    NSUInteger len = [numberStr length];
    
    int firstGroupLength = len % 3;
    int index = 0;
    
    if (firstGroupLength == 1) {
        [result appendString:[self readOneDigit:[numberStr substringToIndex:1]]];
        index += 1;
    }
    else if (firstGroupLength == 2) {
        [result appendString:[self readGroupOfTwoDigits:[numberStr substringToIndex:2]]];
        index += 2;
    }
    
    if (index > 0) {
        [result appendString:@" "];
        [result appendString:[self readGroup3Unit:(len - index)/3]];
    }
    
    for (; index < len; index += 3) {
        if ([[numberStr substringWithRange:NSMakeRange(index, 3)] isEqualToString:@"000"]) continue;
        
        if (index > 0) [result appendString:@", "];
        [result appendString:[self readGroupOfThreeDigits:[numberStr substringWithRange:NSMakeRange(index, 3)]]];

        [result appendString:@" "];
        [result appendString:[self readGroup3Unit:(len - index)/3 - 1]];
    }
    
    return result;
}

- (NSString *) readGroup3Unit:(int)groupNumber {
    if (groupNumber <= 0) return @"";

    int x = groupNumber % _group3Unit.count;
    int y = groupNumber / _group3Unit.count;
    
    NSMutableString *result = [NSMutableString new];
    
    if (x > 0) [result appendString:_group3Unit[x - 1]];
    
    for (int i = 0; i < y; i++) {
        if (x > 0) [result appendString:@" "];
        [result appendString:_group3Unit.lastObject];
    }
    
    return result;
}
         
- (NSString *) readOneDigit:(NSString *)digitStr {
    return _0To9[digitStr];
}

- (NSString *) readGroupOfTwoDigits:(NSString *)digitStr {
    NSMutableString *result = [NSMutableString new];
    NSString *firstDigit = [digitStr substringToIndex:1];
    NSString *secondDigit = [digitStr substringWithRange:NSMakeRange(1, 1)];
    
    if ([firstDigit isEqualToString:@"0"]) {
        if (![secondDigit isEqualToString:@"0"]) {
            [result appendString:_0To9[secondDigit]];
        }
    }
    else if ([firstDigit isEqualToString:@"1"]) {
        [result appendString:_10To19[digitStr]];
    }
    else {
        [result appendString:_x10[firstDigit]];
        if (![secondDigit isEqualToString:@"0"]) {
            [result appendString:@" "];
            [result appendString:_0To9[secondDigit]];
        }
    }

    return result;
}

- (NSString *) readGroupOfThreeDigits:(NSString *)digitStr {
    NSMutableString *result = [NSMutableString new];
    NSString *firstDigit = [digitStr substringToIndex:1];
    
    if (![firstDigit isEqualToString:@"0"]) {
        [result appendString:[self readOneDigit:[digitStr substringToIndex:1]]];
        [result appendString:@" hundred "];
    }
    
    [result appendString:[self readGroupOfTwoDigits:[digitStr substringWithRange:NSMakeRange(1, 2)]]];

    return result;
}


         
@end