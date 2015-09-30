//
//  ChessView.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/30/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ChessView.h"

@interface ChessView ()

@end

@implementation ChessView
{
    CGFloat _margin;
    CGFloat _h0;
    UIView *_containerView;
}

- (void) loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _margin = 10.0;
    _h0 = 160.0;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - _margin * 2.0, self.view.bounds.size.width - _margin * 2.0)];
    _containerView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_containerView];
    
    _containerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    
    CGFloat cellWidth = (self.view.bounds.size.width - _margin * 2.0) / 8.0;
    
    for (int rowIndex = 0; rowIndex < 8; rowIndex++) {
        for (int colIndex = 0; colIndex < 8; colIndex++) {
            CGRect rect = CGRectMake((CGFloat)colIndex * cellWidth, (CGFloat)rowIndex * cellWidth, cellWidth, cellWidth);
            UIView *cell = [[UIView alloc] initWithFrame:rect];
            
            if (rowIndex % 2 == 0) {
                cell.backgroundColor = (colIndex % 2 == 0) ? [UIColor blackColor] : [UIColor whiteColor];
            }
            else {
                cell.backgroundColor = (colIndex % 2 == 0) ? [UIColor whiteColor] : [UIColor blackColor];
            }
            
            [_containerView addSubview:cell];
        }
    }
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height - 100, self.view.bounds.size.width - 40, 10)];
    
    slider.minimumValue = -1;
    slider.maximumValue = 1;
    slider.value = 0;
    [slider addTarget:self action:@selector(onRotate:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
}

- (void) onRotate:(UISlider *)sender {
    _containerView.transform = CGAffineTransformMakeRotation((CGFloat)sender.value * (CGFloat)M_PI);
}

- (void) viewDidLoad {
    [super viewDidLoad];

}


@end
