//
//  ScaleWithSlider.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/7/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ScaleWithSlider.h"

@interface ScaleWithSlider () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@end

@implementation ScaleWithSlider
{
    UIImageView *_photo;
    UIToolbar *_toolbar;
    UISlider *_slider;
    UILabel *_zoomScaleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self addToolbar];
    [self addScrollView];
}

- (void) addToolbar {
    _toolbar = [UIToolbar new];
    [_toolbar sizeToFit];

    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 80, 40)];
    _slider.minimumValue = 0.2;
    _slider.maximumValue = 4.0;
    _slider.value = 1.0;
 
    [_slider addTarget:self
                action:@selector(onSliderChange:)
      forControlEvents:UIControlEventValueChanged];
    
    _zoomScaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    _zoomScaleLabel.text = [NSString stringWithFormat:@"%.2f", _slider.value];
    _zoomScaleLabel.textAlignment = NSTextAlignmentCenter;
    _zoomScaleLabel.textColor = [UIColor blackColor];
    _zoomScaleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithCustomView:_slider];
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithCustomView:_zoomScaleLabel];
    
    _toolbar.items = @[barButton1, barButton2];

    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    _toolbar.frame = CGRectMake(0, marginTop, _toolbar.bounds.size.width, _toolbar.bounds.size.height);
    
    [self.view addSubview:_toolbar];
}

- (void) addScrollView {
    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height + _toolbar.bounds.size.height;
    CGRect scrollRect = CGRectMake(0, marginTop, self.view.bounds.size.width, self.view.bounds.size.height - marginTop);
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollRect];
 
    _photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travel.jpg"]];
    [self.scrollView addSubview:_photo];
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = _slider.minimumValue;
    self.scrollView.maximumZoomScale = _slider.maximumValue;
    self.scrollView.zoomScale = _slider.value;
    
    [self.view addSubview:self.scrollView];
}


- (void) onSliderChange:(UISlider *)sender {
    self.scrollView.zoomScale = _slider.value;
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photo;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    _slider.value = self.scrollView.zoomScale;
    _zoomScaleLabel.text = [NSString stringWithFormat:@"%.2f", self.scrollView.zoomScale];
}

@end
