//
//  PhotoDetailViewController.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/8/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "PhotoDetailViewController.h"
#define ZOOM_STEP 1.5

@interface PhotoDetailViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *photo;
@property (nonatomic, weak) UILabel *scaleLabel;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addScrollView];
}

- (void) addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.1;
    scrollView.maximumZoomScale = 10.0;
    scrollView.clipsToBounds = YES;
    
    scrollView.backgroundColor = [UIColor grayColor];
    
    UIImageView *photo = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    photo.image = _image;
    photo.contentMode = UIViewContentModeScaleAspectFit;
    photo.userInteractionEnabled = YES;
    photo.multipleTouchEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    [photo addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [photo addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [scrollView addSubview:photo];
    self.photo = photo;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UILabel *scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    scaleLabel.textAlignment = NSTextAlignmentRight;
    scaleLabel.text = [NSString stringWithFormat:@"%.2f", scrollView.zoomScale];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:scaleLabel];
    
    [self.navigationItem setRightBarButtonItem:barButton];
    self.scaleLabel = scaleLabel;
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.photo;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
    self.scaleLabel.text = [NSString stringWithFormat:@"%.2f", self.scrollView.zoomScale];
}

- (void) onTap:(UITapGestureRecognizer *)tap {
    CGPoint tapPoint = [tap locationInView:self.photo];
    float newScale = self.scrollView.zoomScale * ZOOM_STEP;
    [self zoomRectForScale:newScale withCenter:tapPoint];
}

- (void) onDoubleTap:(UITapGestureRecognizer *)tap {
    CGPoint tapPoint = [tap locationInView:self.photo];
    float newScale = self.scrollView.zoomScale / ZOOM_STEP;
    [self zoomRectForScale:newScale withCenter:tapPoint];
}

- (void) zoomRectForScale:(float)scale
               withCenter:(CGPoint)center {
    CGRect zoomRect;
    CGSize scrollViewSize = self.scrollView.bounds.size;

    zoomRect.size.width = scrollViewSize.width / scale;
    zoomRect.size.height = scrollViewSize.height / scale;
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

@end
