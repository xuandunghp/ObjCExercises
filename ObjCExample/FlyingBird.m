//
//  FlyingBird.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/1/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "FlyingBird.h"

@interface FlyingBird ()

@end

@implementation FlyingBird
{
    UIImageView *_bird;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self drawJungle];
    [self addBird];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self flyUpAndDown];
}


- (void) drawJungle {
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jungle.jpg"]];
    background.frame = self.view.bounds;
    background.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:background];
}

- (void) addBird {
    _bird = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 68)];
    _bird.animationImages = @[[UIImage imageNamed:@"bird0.png"],
                              [UIImage imageNamed:@"bird1.png"],
                              [UIImage imageNamed:@"bird2.png"],
                              [UIImage imageNamed:@"bird3.png"],
                              [UIImage imageNamed:@"bird4.png"],
                              [UIImage imageNamed:@"bird5.png"]
                              ];
    _bird.animationDuration = 1.0;
    _bird.animationRepeatCount = -1;
    [self.view addSubview:_bird];
    [_bird startAnimating];
}

- (void) flyUpAndDown {
    _bird.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:5.0
                     animations:^{
                         _bird.center = CGPointMake(self.view.bounds.size.width - 55, self.view.bounds.size.height - 34);
                     }
                     completion:^(BOOL finished){
                         _bird.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(-1, 1), CGAffineTransformMakeRotation(M_PI_4));
                         [UIView animateWithDuration:5.0
                                          animations:^{
                                              _bird.center = CGPointMake(55, 34);
                                          }
                                          completion:^(BOOL finished) {
                                              [self flyUpAndDown];
                                          }
                          ];
                     }
     ];
}



@end
