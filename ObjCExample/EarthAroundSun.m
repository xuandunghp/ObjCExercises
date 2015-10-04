//
//  EarthAroundSun.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/2/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "EarthAroundSun.h"

@interface EarthAroundSun ()

@end

@implementation EarthAroundSun
{
    UIImageView *_sun;
    UIImageView *_earth;
    UIImageView *_moon;
    UISlider *_slider;
    
    CGFloat _margin;
    
    CGFloat _distanceSunToEarth;
    CGFloat _distanceEarthToMoon;
    
    CGFloat _angleEarthAroundSun;
    CGFloat _angleEarthAroundSunDelta;
    
    CGFloat _angleMoonAroundEarth;
    CGFloat _angleMoonAroundEarthDelta;
    
    CGFloat _angleEarthRotation;
    CGFloat _angleEarthRotationDelta;
    
    NSTimer *_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _margin = 20;
    
    _distanceSunToEarth = (self.view.bounds.size.width * 0.5 - _margin) * 0.75;
    _distanceEarthToMoon = (self.view.bounds.size.width * 0.5 - _margin) * 0.25;
    
    [self drawElements];
    [self animate];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void) drawElements {
    CGSize mainViewSize = self.view.bounds.size;

    _sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun"]];
    _sun.frame = CGRectMake(0, 0, 80, 80);
    _sun.center = self.view.center;
    [self.view addSubview:_sun];
    
    _earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    _earth.frame = CGRectMake(0, 0, 40, 40);
    _earth.center = CGPointMake(_sun.center.x - _distanceSunToEarth, self.view.center.y);
    [self.view addSubview:_earth];
    
    _moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon"]];
    _moon.frame = CGRectMake(0, 0, 25, 25);
    _moon.center = CGPointMake(_earth.center.x - _distanceEarthToMoon, self.view.center.y);
    [self.view addSubview:_moon];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(_margin, mainViewSize.height - 100, mainViewSize.width - 2 * _margin, 50)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    _slider.value = 0.5;
    [self.view addSubview:_slider];

    [_slider addTarget:self
                action:@selector(changeSpeed:)
      forControlEvents:UIControlEventValueChanged];
}

- (void) animate {
    _angleEarthAroundSun = 0;
    _angleMoonAroundEarth = 0;
    _angleEarthRotation = 0;
    
    [self updateSpeed];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                              target:self
                                            selector:@selector(updatePosition)
                                            userInfo:nil
                                             repeats:true];
}

- (void) updatePosition {
    _angleEarthAroundSun += _angleEarthAroundSunDelta;
    _earth.center = [self calculateEarthPosition];
    
    _angleEarthRotation += _angleEarthRotationDelta;
    _earth.transform = CGAffineTransformMakeRotation(_angleEarthRotation);
    
    _angleMoonAroundEarth += _angleMoonAroundEarthDelta;
    _moon.center = [self calculateMoonPosition];
}

- (CGPoint) calculateEarthPosition {
    return CGPointMake(_sun.center.x - sin(_angleEarthAroundSun) * _distanceSunToEarth,
                       _sun.center.y - cos(_angleEarthAroundSun) * _distanceSunToEarth);
}

- (CGPoint) calculateMoonPosition {
    return CGPointMake(_earth.center.x - sin(_angleMoonAroundEarth) * _distanceEarthToMoon,
                       _earth.center.y - cos(_angleMoonAroundEarth) * _distanceEarthToMoon);
}

- (void) changeSpeed:(UISlider *)sender {
    [self updateSpeed];
}

- (void) updateSpeed {
    _angleEarthAroundSunDelta = -0.01 * _slider.value * _slider.value;
    _angleMoonAroundEarthDelta = _angleEarthAroundSunDelta * 12;
    _angleEarthRotationDelta = _angleMoonAroundEarthDelta * 30;
}

@end
