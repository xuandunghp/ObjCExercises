
//
//  RollingBall.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/2/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "RollingBall.h"

@interface RollingBall ()

@end

@implementation RollingBall
{
    UIImageView *_ball;
    NSTimer *_timer;
    CGFloat _angle;
    CGFloat _deltaAngle;
    CGFloat _ballRadius;
    CGFloat _margin;
    UISlider *_slider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _margin = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawBall];
    [self drawSlider];
    [self animate];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}



- (void) drawBall {
    _ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    _ballRadius = _ball.bounds.size.width * 0.5;
    _ball.center = CGPointMake(_ballRadius + _margin, self.view.center.y);
    [self.view addSubview:_ball];
}

- (void) animate {
    _angle = 0;
    _deltaAngle = _slider.value;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                              target:self
                                            selector:@selector(rollBall)
                                            userInfo:nil
                                             repeats:true];
}

- (void) rollBall {
    CGFloat newBallCenterX = _ball.center.x + _deltaAngle * _ballRadius;
    
    if (newBallCenterX < _ballRadius + _margin || newBallCenterX > self.view.bounds.size.width - _ballRadius - _margin) {
        _deltaAngle = -_deltaAngle;
        newBallCenterX = _ball.center.x + _deltaAngle * _ballRadius;
    }
    
    _angle += _deltaAngle;
    _ball.center = CGPointMake(newBallCenterX, _ball.center.y);
    _ball.transform = CGAffineTransformMakeRotation(_angle);
}



- (void) drawSlider {
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, 50)];
    _slider.minimumValue = 0.0;
    _slider.maximumValue = 0.5;
    _slider.value = 0.25;
    _slider.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100);
    
    [self.view addSubview:_slider];
    [_slider addTarget:self
                action:@selector(changeSpeed:)
      forControlEvents:UIControlEventValueChanged];
}

- (void) changeSpeed:(UISlider *)sender {
    _deltaAngle = ((_deltaAngle > 0) ? 1 : -1) * _slider.value;
    
}

@end
