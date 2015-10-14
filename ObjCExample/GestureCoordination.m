//
//  GestureCoordination.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/12/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "GestureCoordination.h"

@interface GestureCoordination () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *ball;

@end

@implementation GestureCoordination
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBall];
}

- (void) addBall {
    self.ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rugby.png"]];
    self.ball.center = self.view.center;
    [self.view addSubview:self.ball];
    
    self.ball.userInteractionEnabled = YES;
    self.ball.multipleTouchEnabled = YES;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onPinch:)];
    pinch.delegate = self;
    [self.ball addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(onRotation:)];
    rotate.delegate = self;
    [self.ball addGestureRecognizer:rotate];
}

- (void) onPinch:(UIPinchGestureRecognizer *)pinch {
    if (pinch.state == UIGestureRecognizerStateRecognized) {
        NSLog(@"Pinch");
        
        UIView *piece = pinch.view;
        CGPoint locationInView = [pinch locationInView:piece];
        CGPoint locationInSuperView = [pinch locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperView;
        
        self.ball.transform = CGAffineTransformScale(self.ball.transform, pinch.scale, pinch.scale);
    }
}

- (void) onRotation:(UIRotationGestureRecognizer *)rotation {
    if (rotation.state == UIGestureRecognizerStateRecognized) {
        NSLog(@"Rotation");
        
        self.ball.transform = CGAffineTransformRotate(self.ball.transform, rotation.rotation);
    }
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
//    // Only recognize Pinch when Rotate fails
//    if ([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]] &&
//        [otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
//        return true;
//    }
//    else {
//        return false;
//    }
    
    // Only recognize Rotate when Pinch fails
    if ([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]] &&
        [otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        return false;
    }
    else {
        return true;
    }
}

@end
