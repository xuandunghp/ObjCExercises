//
//  StarField.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/2/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "StarField.h"

@interface StarField ()

@end

@implementation StarField
{
    UIImageView *_brownStar, *_greenStar, *_redStar, *_violetStar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawStars];
    [self animate:0];
}

- (void) drawStars {
    _brownStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brown.png"]];
    _greenStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green.png"]];
    _redStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red.png"]];
    _violetStar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"violet.png"]];
    
    _brownStar.center = self.view.center;
    _greenStar.center = self.view.center;
    _redStar.center = self.view.center;
    _violetStar.center = self.view.center;
    
    [self.view addSubview:_brownStar];
    [self.view addSubview:_greenStar];
    [self.view addSubview:_redStar];
    [self.view addSubview:_violetStar];
}

- (void) animate:(int)phase {
    NSTimeInterval duration;
    
    switch (phase) {
        case 2:
            duration = 3.0;
            break;
            
        default:
            duration = 1.0;
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        switch (phase) {
            case 0:
                _brownStar.center = CGPointMake(_brownStar.center.x + 100, _brownStar.center.y - 100);
                _brownStar.transform = CGAffineTransformMakeScale(1.5, 1.5);
                
                _greenStar.center = CGPointMake(_greenStar.center.x - 100, _greenStar.center.y - 100);
                _greenStar.transform = CGAffineTransformMakeScale(1.5, 1.5);
                
                _redStar.center = CGPointMake(_redStar.center.x - 100, _redStar.center.y + 100);
                _redStar.transform = CGAffineTransformMakeScale(1.5, 1.5);
                
                _violetStar.center = CGPointMake(_violetStar.center.x + 100, _violetStar.center.y + 100);
                _violetStar.transform = CGAffineTransformMakeScale(1.5, 1.5);
                
                break;
            
            case 1:
                _brownStar.center = CGPointMake(_brownStar.center.x - 100, _brownStar.center.y);
                _greenStar.center = CGPointMake(_greenStar.center.x, _greenStar.center.y + 100);
                _redStar.center = CGPointMake(_redStar.center.x + 100, _redStar.center.y);
                _violetStar.center = CGPointMake(_violetStar.center.x, _violetStar.center.y - 100);
                break;
                
            case 2:
                _brownStar.center = CGPointMake(_brownStar.center.x, _brownStar.center.y + 100);
                _brownStar.transform = CGAffineTransformMakeScale(1, 1);
                
                _greenStar.center = CGPointMake(_greenStar.center.x + 100, _greenStar.center.y);
                _greenStar.transform = CGAffineTransformMakeScale(1, 1);
                
                _redStar.center = CGPointMake(_redStar.center.x, _redStar.center.y - 100);
                _redStar.transform = CGAffineTransformMakeScale(1, 1);
                
                _violetStar.center = CGPointMake(_violetStar.center.x - 100, _violetStar.center.y);
                _violetStar.transform = CGAffineTransformMakeScale(1, 1);

                break;
                
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        [self animate:(phase + 1) % 3];
    }];
}

@end
