//
//  AdvancedSlider2.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/23/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "AdvancedSlider2.h"

#define PASSED_TIME_TAG 100
#define REMAINING_TIME_TAG 200

@interface AdvancedSlider2 ()

@end

@implementation AdvancedSlider2
{
    NSTimer *_timer;
    float _loadedRatio;
    int _totalLengthInSecond;
    
    UIImageView *_sliderContainer;
    UISlider *_slider;
    UIImageView *_loadingIndicator;
    UIImageView *_passedTimeBalloon;
    UILabel *_passedTimeIndicator;
    UILabel *_remainingTimeIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _totalLengthInSecond = 960;
    _loadedRatio = 0.0;
    _slider.value = 0.0;
    
    [self drawBackground];
    [self drawSlider];

    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self updateSlider];
    
    [self startSliderAnimation];
}

- (void) drawBackground {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"as2_background.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void) drawSlider {
    _sliderContainer = [self drawSliderContainer];
    [self.view addSubview:_sliderContainer];
    
    _loadingIndicator = [self drawLoadingIndicator:_sliderContainer];
    [_sliderContainer addSubview:_loadingIndicator];
    
    _slider = [self drawSliderControl:_sliderContainer];
    [_sliderContainer addSubview:_slider];
    
    _passedTimeBalloon = [self drawPassedTimeBalloon];
    [_sliderContainer addSubview:_passedTimeBalloon];
    
    _passedTimeIndicator = [self drawPassedTimeIndicator:_passedTimeBalloon];
    [_passedTimeBalloon addSubview:_passedTimeIndicator];
    
    _remainingTimeIndicator = [self drawRemainingTimeIndicator:_sliderContainer];
    [_sliderContainer addSubview:_remainingTimeIndicator];
}

- (UIImageView *) drawSliderContainer {
    UIImageView *sliderContainer = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"as2_slider_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)]];

    CGRect frame = sliderContainer.frame;
    frame.origin = CGPointMake(20.0, (self.view.bounds.size.height - frame.size.height) / 2);
    frame.size.width = self.view.bounds.size.width - 75.0;
    sliderContainer.frame = frame;
    
    [sliderContainer setUserInteractionEnabled:YES];
    return sliderContainer;
}

- (UISlider *) drawSliderControl:(UIView *)container {
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(-2.0, 0.0, container.bounds.size.width + 4.0, container.bounds.size.height)];

    [slider setThumbImage:[UIImage imageNamed:@"as2_thumb"]
                 forState:UIControlStateNormal];
    
    [slider setMinimumTrackImage:[[UIImage imageNamed:@"as2_mintrack"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)]
                        forState:UIControlStateNormal];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, container.bounds.size.height), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [slider setMaximumTrackImage:blank
                        forState:UIControlStateNormal];

    return slider;
}

- (UIImageView *) drawLoadingIndicator:(UIView *)container {
    return [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, container.bounds.size.height)];
}

- (UIImageView *) drawPassedTimeBalloon {
    UIImageView *passedTime = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"as2_balloon"]];

    CGRect frame = passedTime.frame;
    frame.origin.y = -frame.size.height - 7.0;
    passedTime.frame = frame;

    return passedTime;
}

- (UILabel *) drawPassedTimeIndicator:(UIView *)container {
    UILabel *passedTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, container.bounds.size.width, container.bounds.size.height - 9)];

    passedTimeLabel.textColor = [UIColor blackColor];
    passedTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    passedTimeLabel.backgroundColor = [UIColor clearColor];
    passedTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    return passedTimeLabel;
}

- (UILabel *) drawRemainingTimeIndicator:(UIView *)container {
    UILabel *remainingTime = [UILabel new];
    remainingTime.textColor = [UIColor blackColor];
    remainingTime.font = [UIFont fontWithName:@"Helvetica" size:12];
    remainingTime.backgroundColor = [UIColor clearColor];
    remainingTime.textAlignment = NSTextAlignmentLeft;
    
    CGRect frame = remainingTime.frame;
    frame.size.width = 50.0;
    frame.size.height = 40.0;
    frame.origin.x = container.bounds.size.width + 10.0;
    frame.origin.y = (container.bounds.size.height - frame.size.height) / 2;
    remainingTime.frame = frame;
    
    return remainingTime;
}



- (void) updateSlider {
    [self updateLoadingIndicator];
    [self updatePassedTimeBalloon];
    [self updateRemainingTimeIndicator];
}

- (void) updateLoadingIndicator {
    UIImage *img = [UIImage imageNamed:((_loadedRatio < 0.99) ? @"as2_maxtrack_incompleted" : @"as2_maxtrack_completed")];
    [_loadingIndicator setImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)]];

    CGRect frame = _loadingIndicator.frame;
    frame.size.width = _loadedRatio * _sliderContainer.bounds.size.width;
    _loadingIndicator.frame = frame;
}

- (void) updatePassedTimeBalloon {
    CGRect frame = _passedTimeBalloon.frame;
    frame.origin.x = (_sliderContainer.bounds.size.width - 13.0) * _slider.value - 19.0;
    _passedTimeBalloon.frame = frame;
    
    int passedSeconds = floor(_slider.value * _loadedRatio * _totalLengthInSecond);
    _passedTimeIndicator.text = [NSString stringWithFormat:@"%d:%02d", passedSeconds / 60, passedSeconds % 60];
}

- (void) updateRemainingTimeIndicator {
    int remainingSeconds = _totalLengthInSecond - floor(_slider.value * _loadedRatio * _totalLengthInSecond);
    _remainingTimeIndicator.text = [NSString stringWithFormat:@"-%d:%02d", remainingSeconds / 60, remainingSeconds % 60];
}



- (void) sliderValueChanged:(UISlider *)sender {
    [self updateSlider];
}



- (void) startSliderAnimation {
    _loadedRatio = 0.0;
    _slider.value = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(onTimer)
                                            userInfo:nil
                                             repeats:true];
}

- (void) onTimer {
    _loadedRatio += 0.1;
    if (_loadedRatio >= 1.0) _loadedRatio = 1.0;

    if (_slider.value >= 1.0) {
        _loadedRatio = 0.0;
        _slider.value = 0.0;
    }
    else {
        _slider.value += 0.06;
    }
    
    [self updateSlider];
}



@end
