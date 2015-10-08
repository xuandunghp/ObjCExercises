//
//  SimpleScroll.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/9/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "SimpleScroll.h"
#define PHOTO_WIDTH 320
#define PHOTO_HEIGHT 480
#define PHOTO_NUM 6

@interface SimpleScroll () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *pageNumber;

@end

@implementation SimpleScroll

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addScrollView];
    [self addPageControl];
    [self addPageNumber];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.scrollView.delegate = nil;
}

- (void) addScrollView {
    CGSize mainViewSize = self.view.bounds.size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((mainViewSize.width - PHOTO_WIDTH) / 2, 0, PHOTO_WIDTH, PHOTO_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(PHOTO_WIDTH * PHOTO_NUM, PHOTO_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < PHOTO_NUM; i++) {
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(PHOTO_WIDTH * i, 0, PHOTO_WIDTH, PHOTO_HEIGHT)];
        photo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i + 1]];
        photo.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:photo];
    }
    
    [self.view addSubview:self.scrollView];
}

- (void) addPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 64 - 40, self.view.bounds.size.width, 40)];
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = PHOTO_NUM;
    [self.pageControl addTarget:self action:@selector(onPageChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.pageControl];
}

- (void) onPageChange:(UIPageControl *)sender {
    [self.scrollView setContentOffset:CGPointMake(PHOTO_WIDTH * self.pageControl.currentPage, 0) animated:NO];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / PHOTO_WIDTH;
    self.pageNumber.text = [NSString stringWithFormat:@"%ld/%d", (long)self.pageControl.currentPage + 1, PHOTO_NUM];
}

- (void) addPageNumber {
    self.pageNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    self.pageNumber.textAlignment = NSTextAlignmentRight;
    [self.pageNumber setText:[NSString stringWithFormat:@"%ld/%d", (long)self.pageControl.currentPage + 1, PHOTO_NUM]];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:self.pageNumber];
    [self.navigationItem setRightBarButtonItem:barButton];
}



@end
