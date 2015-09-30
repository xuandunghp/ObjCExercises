//
//  BasicView.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/30/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "BasicView.h"

@interface BasicView ()

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UISlider *rotateSlider;
@property (weak, nonatomic) IBOutlet UISlider *scaleSlider;

@end

@implementation BasicView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onShow:(UISwitch *)sender {
    _myView.hidden = !sender.on;
}

- (IBAction)onAlphaChange:(UISlider *)sender {
    _myView.alpha = (CGFloat)sender.value;
}

- (IBAction)onRotate:(UISlider *)sender {
    [self rotateAndScale];
}

- (IBAction)onScaleChange:(UISlider *)sender {
    [self rotateAndScale];
}

- (IBAction)onColorChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _myView.backgroundColor = [UIColor blackColor];
            break;

        case 1:
            _myView.backgroundColor = [UIColor redColor];
            break;

        case 2:
            _myView.backgroundColor = [UIColor greenColor];
            break;

        case 3:
            _myView.backgroundColor = [UIColor blueColor];
            break;
            
        default:
            break;
    }
}

- (void) rotateAndScale {
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation((CGFloat)_rotateSlider.value * (CGFloat)M_PI);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale((CGFloat)_scaleSlider.value, (CGFloat)_scaleSlider.value);
    _myView.transform = CGAffineTransformConcat(rotateTransform, scaleTransform);
}


@end
