//
//  DictionaryDemo.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/28/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "DictionaryDemo.h"

@interface DictionaryDemo ()

@end

@implementation DictionaryDemo
{
    NSDictionary *_famousFootballTeams;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _famousFootballTeams = @{
                             @"a": @[@"AS Roma", @"Arsenal", @"AC Milan", @"Atletico Maldrid", @"AS Monaco", @"Ajax Amsterdam"],
                             @"b": @[@"Barcelona", @"Borussia Dortmund", @"Bayern Munich", @"Bayern Levekusel", @"Besiktas", @"Basel", @"Benfica"],
                             @"c": @[@"Chelsea", @"CSKA Moscow"],
                             @"d": @[],
                             @"e": @[@"Everton"],
                             @"f": @[@"Fiorentina", @"Fenerbahce"],
                             @"g": @[@"Galatasaray"],
                             @"h": @[],
                             @"i": @[@"Inter Milan"],
                             @"j": @[@"Juventus"],
                             @"k": @[],
                             @"l": @[@"Liverpool", @"Lazio Roma"],
                             @"m": @[@"Manchester United", @"Manchester City"],
                             @"n": @[@"Newcastle United", @"Napoli"],
                             @"o": @[@"Olympic Lyon", @"Olympic Marseille", @"Olympiakos"],
                             @"p": @[@"Paris Saint German", @"PSV Eindhoven"],
                             @"q": @[],
                             @"r": @[@"Real Maldrid"],
                             @"s": @[@"Schalke 04", @"Sevilla", @"Sporting Lisbon"],
                             @"t": @[@"Tottenham Hotspur"],
                             @"u": @[],
                             @"v": @[@"Valencia", @"Villarreal"],
                             @"w": @[@"Wolfburg"],
                             @"x": @[],
                             @"y": @[],
                             @"z": @[]
                           };
    
    
    NSArray *test = @[@"Bayern Munich", @"Swansea", @"Barcelona", @"abc", @"city", @"Real Maldrid"];
    [self writeln:@"Are these clubs famous football teams?\n"];
    for (NSString *team in test) {
        [self writeln:[NSString stringWithFormat:@"%@: %@", team, [self isFamousFootballTeam:team] ? @"YES" : @"NO"]];
    }
    
}

- (bool) isFamousFootballTeam:(NSString *)team {
    NSArray *arr = _famousFootballTeams[[[team substringToIndex:1] lowercaseString]];
    
    if (arr == nil) {
        return false;
    }
    else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", team];
        NSArray *found = [arr filteredArrayUsingPredicate:predicate];
        return [found count] > 0;
    }
}


@end
