//
//  DemoSilder.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/21/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "BasicSlider.h"

@interface BasicSlider ()
{
    NSTimer* _timer;
    bool _shouldResetSlider;
    __weak IBOutlet UISlider *slider;
}
@end

@implementation BasicSlider

- (void) viewDidLoad {
    [super viewDidLoad];

    slider.value = 0;
    _shouldResetSlider = false;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:true];
    
    slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    slider.tintColor = [UIColor redColor];
    slider.thumbTintColor = [UIColor blueColor];
}

- (void) onTimer {
    if (_shouldResetSlider) {
        slider.value = 0;
        _shouldResetSlider = false;
    }
    else {
        slider.value += 0.05;
        if (slider.value >= 1.0) {
            slider.value = 1.0;
            _shouldResetSlider = true;
        }
    }
}

@end
