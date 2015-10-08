//
//  BasicScrollView.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/6/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "BasicScrollView.h"

@interface BasicScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;

@end

@implementation BasicScrollView
{
    UIImageView *_photo;
    UILabel *_zoomScaleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self addScrollView];
    [self addLabelToNavigationBar];
}

- (void) addScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"travel.jpg"]];
    [self.scrollView addSubview:_photo];

    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 4.0;
    
    [self.view addSubview:self.scrollView];
}

- (void) addLabelToNavigationBar {
    _zoomScaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    _zoomScaleLabel.textAlignment = NSTextAlignmentRight;
    [_zoomScaleLabel setText:[NSString stringWithFormat:@"%.2f", self.scrollView.zoomScale]];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:_zoomScaleLabel];
    
    [self.navigationItem setRightBarButtonItem:barButton];
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photo;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    [_zoomScaleLabel setText:[NSString stringWithFormat:@"%.2f", self.scrollView.zoomScale]];
}

@end
