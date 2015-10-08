//
//  ContentSizeBasic.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/7/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ContentSizeBasic.h"

@interface ContentSizeBasic ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ContentSizeBasic

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addScrollView];
}

- (void) addScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width - 16, 300)];
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    UIImageView *photo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"people.jpg"]];
    [self.scrollView addSubview:photo];
    
    self.scrollView.contentSize = CGSizeMake(photo.bounds.size.width, photo.bounds.size.height);
    
    self.scrollView.bounces = true;
    self.scrollView.showsVerticalScrollIndicator = true;
    self.scrollView.showsHorizontalScrollIndicator = true;
    
    [self.view addSubview:self.scrollView];
}



@end
