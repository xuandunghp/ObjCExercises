//
//  WordCount.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/28/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "WordCount.h"
#import "NSArray+Extend.h"

@interface WordCount ()

@end

@implementation WordCount
{
    NSArray *_trivialWords;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _trivialWords = @[@"I", @"you", @"we", @"they", @"her", @"him", @"our", @"it", @"am", @"is", @"are", @"was", @"were", @"to", @"a", @"an", @"the", @"in", @"on", @"for", @"of", @"by", @"but", @"and", @"this", @"that", @"there", @"what", @"which", @"where", @"would", @"when", @"as", @"not"];


    NSString *inputText = @"I am happy to join with you today in what will go down in history as the greatest demonstration for freedom in the history of our nation. \
    \
    Five score years ago, a great American, in whose symbolic shadow we stand today, signed the Emancipation Proclamation. This momentous decree came as a great beacon light of hope to millions of Negro slaves who had been seared in the flames of withering injustice. It came as a joyous daybreak to end the long night of their captivity. \
    \
    But one hundred years later, the Negro still is not free. One hundred years later, the life of the Negro is still sadly crippled by the manacles of segregation and the chains of discrimination. One hundred years later, the Negro lives on a lonely island of poverty in the midst of a vast ocean of material prosperity. One hundred years later, the Negro is still languished in the corners of American society and finds himself an exile in his own land. And so we've come here today to dramatize a shameful condition. \
    \
    In a sense we've come to our nation's capital to cash a check. When the architects of our republic wrote the magnificent words of the Constitution and the Declaration of Independence, they were signing a promissory note to which every American was to fall heir. This note was a promise that all men, yes, black men as well as white men, would be guaranteed the \"unalienable Rights\" of \"Life, Liberty and the pursuit of Happiness.\" It is obvious today that America has defaulted on this promissory note, insofar as her citizens of color are concerned. Instead of honoring this sacred obligation, America has given the Negro people a bad check, a check which has come back marked \"insufficient funds.\"";
    
    NSDictionary *words = [self extractWordsFromText:inputText];

    
    NSArray *keys = [words allKeys];
    
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *n1 = [words objectForKey:obj1];
        NSNumber *n2 = [words objectForKey:obj2];
        
        return [n2 compare:n1];
    }];
    
    for (id key in sortedKeys) {
        [self writeln:[NSString stringWithFormat:@"%@: %@", key, words[key]]];
    }
}

- (NSDictionary *) extractWordsFromText:(NSString *)input {
    NSString *cleanText = [self sanitizeText:input];

    NSArray *words = [self tokenizeText:cleanText];
    
    NSDictionary *wordsCounted = [words countElements];
    
    NSDictionary *result = [self removeTrivialWords:wordsCounted];
    
    return result;
}

- (NSString *) sanitizeText:(NSString *)text {
    NSString *result = [text lowercaseString];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\.|,|\"|'s|'ve" options:0 error:nil];
    result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, [result length]) withTemplate:@" "];

    regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+" options:0 error:nil];
    result = [regex stringByReplacingMatchesInString:result options:0 range:NSMakeRange(0, [result length]) withTemplate:@" "];
    
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return result;
}

- (NSArray *) tokenizeText:(NSString *)text {
    return [text componentsSeparatedByString:@" "];
}

- (NSDictionary *) removeTrivialWords:(NSDictionary *)words {
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:words];
    
    for (NSString *w in _trivialWords) {
        [result removeObjectForKey:[w lowercaseString]];
    }
    
    return result;
}

@end
