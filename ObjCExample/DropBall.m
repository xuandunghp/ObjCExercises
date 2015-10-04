//
//  DropBall.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/3/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "DropBall.h"

@interface DropBall ()

@end

@implementation DropBall
{
    UIImageView *_ball;
    CGFloat _ballRadius;
    
    CGFloat _y;
    CGFloat _minY;
    CGFloat _maxY;
    
    CGFloat _velocity;
    CGFloat _accelerateY;
    
    
    NSTimer *_timer;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addBall];
    [self dropBall];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void) addBall {
    CGSize mainViewSize = self.view.bounds.size;

    _ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
    _ballRadius = _ball.bounds.size.width * 0.5;
    _ball.center = CGPointMake(mainViewSize.width * 0.5, _ballRadius);
    
    [self.view addSubview:_ball];
}

- (void) dropBall {
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;

    _minY = _ballRadius;
    _maxY = mainViewSize.height - statusBarHeight - _ballRadius;
    _y = _minY;
    
    _velocity = 0.0;
    _accelerateY = 0.5;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateBallPosition) userInfo:nil repeats:true];
}

- (void) updateBallPosition {
    _velocity += _accelerateY;
    _y += _velocity;

    if (_y > _maxY) {
        _velocity = -_velocity * 0.95;
        _y = _maxY;
    }
    
    _ball.center = CGPointMake(_ball.center.x, _y);
}

@end
