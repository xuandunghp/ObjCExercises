//
//  DemoSliderAdvanced.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/21/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "AdvancedSlider1.h"

@interface AdvancedSlider1 ()
{
    NSTimer *_timer;
    __weak IBOutlet UISlider *_slider;
    __weak IBOutlet UIImageView *_sliderBackground;
}

@end

@implementation AdvancedSlider1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawBackground];
    [self drawSlider];
    [self startSliderAnimation];
}

- (void) drawBackground {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"as1_background.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void) drawSlider {
    [_slider setThumbImage:[UIImage imageNamed:@"as1_thumb"] forState:UIControlStateNormal];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 20, 0, 20);
    [_sliderBackground setImage:[[UIImage imageNamed:@"as1_slider_bg"] resizableImageWithCapInsets:inset]];
    
    [_slider setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
}

- (void) startSliderAnimation {
    _slider.value = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:true];
}

- (void) onTimer {
    _slider.value = (_slider.value >= 1.0) ? 0.0 : (_slider.value + 0.05);
}


@end
