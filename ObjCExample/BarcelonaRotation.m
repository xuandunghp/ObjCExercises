//
//  BarcelonaFormation.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/25/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "BarcelonaRotation.h"

#define NAME @"name"
#define NUMBER @"number"
#define POSITION @"position"

#define GK @"GK"
#define DF @"DF"
#define MF @"MF"
#define FW @"FW"


@interface BarcelonaRotation ()

@end

@implementation BarcelonaRotation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *players = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BarcelonaPlayers" ofType:@"plist"]];
    NSMutableArray *goalKeepers = [NSMutableArray new];
    NSMutableArray *defenders = [NSMutableArray new];
    NSMutableArray *midfielders = [NSMutableArray new];
    NSMutableArray *forwards = [NSMutableArray new];
    
    
    for (NSDictionary *player in players) {
        if ([player[POSITION] isEqualToString:GK]) {
            [goalKeepers addObject:player];
        }
        else if ([player[POSITION] isEqualToString:DF]) {
            [defenders addObject:player];
        }
        else if ([player[POSITION] isEqualToString:MF]) {
            [midfielders addObject:player];
        }
        else if ([player[POSITION] isEqualToString:FW]) {
            [forwards addObject:player];
        }
    }
    
    NSMutableArray *selectedEleven = [[NSMutableArray alloc] initWithCapacity:11];
    
    [selectedEleven addObjectsFromArray:[self randomPickPlayers:1 From:goalKeepers]];
    [selectedEleven addObjectsFromArray:[self randomPickPlayers:4 From:defenders]];
    [selectedEleven addObjectsFromArray:[self randomPickPlayers:4 From:midfielders]];
    [selectedEleven addObjectsFromArray:[self randomPickPlayers:2 From:forwards]];

    for (NSDictionary *player in selectedEleven) {
        [self writeln:[NSString stringWithFormat:@"%@ - %@ [%@]", player[POSITION], player[NAME], player[NUMBER]]];
    }
}

- (NSArray *) randomPickPlayers:(int)numberOfPlayers From:(NSArray *)players {
    NSMutableArray *playerPool = [[NSMutableArray alloc] initWithArray:players];
    NSMutableArray *pickedPlayers = [NSMutableArray new];
    
    for (int i = 0; i < numberOfPlayers; i++) {
        NSUInteger randomIndex = arc4random() % [playerPool count];
        [pickedPlayers addObject:playerPool[randomIndex]];
        [playerPool removeObjectAtIndex:randomIndex];
    }
    
    return pickedPlayers;
}


@end
