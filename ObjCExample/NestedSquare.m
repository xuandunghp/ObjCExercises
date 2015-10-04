//
//  NestedSquare.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/30/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "NestedSquare.h"
#import "AudioToolbox/AudioServices.h"

@interface NestedSquare ()

@end

@implementation NestedSquare
{
    NSTimer *_timer;
    int _rotationTurn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    [self drawAllSquares];
    [self animate];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}


- (void) drawAllSquares {
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat margin = 20.0;
    CGFloat recWidth = mainViewSize.width - margin * 2.0;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    CGPoint center = CGPointMake(mainViewSize.width * 0.5, (mainViewSize.height + statusBarHeight) * 0.5);
    
    for (int i = 0; i < 10; i++) {
        if (i % 2 == 0) {
            [self drawSquareByWidth:recWidth andRotate:false atCenter:center];
        }
        else {
            [self drawSquareByWidth:recWidth andRotate:true atCenter:center];
        }
        
        recWidth /= sqrt(2);
    }
}

- (void) animate {
    _rotationTurn = 1;
    
    [self rotateAllSquares];
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(rotateAllSquares) userInfo:nil repeats:true];
}

- (void) drawSquareByWidth:(CGFloat)width
                 andRotate:(BOOL)rotate
                  atCenter:(CGPoint)center {
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    square.center = center;
    square.transform = rotate ? CGAffineTransformMakeRotation(M_PI_4) : CGAffineTransformIdentity;
    square.backgroundColor = rotate ? [UIColor whiteColor] : [UIColor darkGrayColor];
    [self.view addSubview:square];
}

- (void) rotateAllSquares {
    [self playSound];
    
    [UIView animateWithDuration:2.0 animations:^{
        for (int i = 0; i < self.view.subviews.count; i++) {
            if (i % 2 == 0) {
                ((UIView *)self.view.subviews[i]).transform = CGAffineTransformMakeRotation(M_PI_4 * _rotationTurn);
            }
            else {
                ((UIView *)self.view.subviews[i]).transform = CGAffineTransformMakeRotation(M_PI_4 * (1 - _rotationTurn));;
            }
        }
        
        _rotationTurn = (_rotationTurn + 1) % 8;
    }];
}

- (void) playSound {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"gunShot" ofType:@"mp3"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
}


@end
