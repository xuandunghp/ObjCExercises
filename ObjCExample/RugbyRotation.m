//
//  RugbyRotation.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/12/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "RugbyRotation.h"

@interface RugbyRotation ()

@property (weak, nonatomic) IBOutlet UIImageView *rugby;

@end

@implementation RugbyRotation
{
    NSTimer *_timer;
    CGFloat _velocity;
    CGFloat _timeInterval;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _velocity = 0;
    _timeInterval = 0.01;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (IBAction)onRotate:(UIRotationGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        _velocity += sender.velocity * 2.5;
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval
                                                  target:self
                                                selector:@selector(rotateBall)
                                                userInfo:nil
                                                 repeats:true];
    }
}

- (void) rotateBall {
    self.rugby.transform = CGAffineTransformRotate(self.rugby.transform, _velocity * _timeInterval);
    
    _velocity *= 0.98;
    
    if (_velocity < 0.01) {
        [_timer invalidate];
        _timer = nil;
        _velocity = 0;
    }
}


@end
