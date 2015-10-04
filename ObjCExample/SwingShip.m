//
//  SwingShip.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/1/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "SwingShip.h"
#import <AVFoundation/AVFoundation.h>

@interface SwingShip ()

@end

@implementation SwingShip
{
    UIImageView *_ship;
    UIImageView *_sea1;
    UIImageView *_sea2;
    NSTimer *_timer;
    AVAudioPlayer *_audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawSeaAndShip];
    [self animateShip:1];
    [self animateSea:1];
    [self playMusic];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_audioPlayer stop];
}

- (void) drawSeaAndShip {
    _sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea1.jpg"]];
    [self.view addSubview:_sea1];
    
    _sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea2.jpg"]];
    _sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_sea2];
    
    _ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boat.png"]];
    _ship.center = CGPointMake(self.view.center.x, self.view.bounds.size.height * 0.7);
    
    [self.view addSubview:_sea1];
    [self.view addSubview:_ship];
}

- (void) animateShip:(int)phase {
    [UIView animateWithDuration:1.0
                     animations:^{
                         switch (phase) {
                             case 1:
                                 _ship.transform = CGAffineTransformMakeRotation(0.08);
                                 break;
                                 
                             case 2:
                                 _ship.transform = CGAffineTransformMakeRotation(-0.08);
                                 break;
                                 
                             default:
                                 break;
                         }
                     } completion:^(BOOL finished) {
                         switch (phase) {
                             case 1:
                                 [self animateShip:2];
                                 break;
                                 
                             case 2:
                                 [self animateShip:1];
                                 break;
                                 
                             default:
                                 break;
                         }
                     }];
}

- (void) animateSea:(int)phase {
    CGRect bounds = self.view.bounds;
    
    
    [UIView animateWithDuration:10.0
                     animations:^{
                         UIImageView *sea1, *sea2;
                         
                         switch (phase) {
                             case 1:
                                 sea1 = _sea1;
                                 sea2 = _sea2;
                                 break;
                                
                             case 2:
                                 sea1 = _sea2;
                                 sea2 = _sea1;
                                 break;
                                
                             default:
                                 break;
                         }
                        
                         sea1.frame = CGRectMake(-bounds.size.width, 0, bounds.size.width, bounds.size.height);
                         sea2.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
                     } completion:^(BOOL finished) {
                         switch (phase) {
                             case 1:
                                 _sea1.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
                                 [self animateSea:2];
                                 break;
                                
                             case 2:
                                 _sea2.frame = CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
                                 [self animateSea:1];
                                 break;
                                
                             default:
                                 break;
                         }
                     }];
}

- (void) playMusic {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sharazan" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

@end
