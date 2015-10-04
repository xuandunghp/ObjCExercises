//
//  DemoColor.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/2/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "DemoColor1.h"
#import "ColorView.h"

@interface DemoColor1 ()

@end

@implementation DemoColor1
{
    ColorView *_view1, *_view2, *_view3, *_view4, *_view5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    CGFloat colorViewWidth = 200.0;
    CGFloat colorViewHeight = 40.0;
    CGFloat x0 = (self.view.bounds.size.width - colorViewWidth) * 0.5;
    
    _view1 = [[ColorView alloc] initWithHex: @"556270"
                                     alpha: 1.0
                                     frame: CGRectMake(x0, 10, colorViewWidth, colorViewHeight)];
    _view2 = [[ColorView alloc] initWithHex: @"4ECDC4"
                                     alpha: 1.0
                                     frame: CGRectMake(x0, 60, colorViewWidth, colorViewHeight)];
    _view3 = [[ColorView alloc] initWithHex: @"C7F464"
                                     alpha: 1.0
                                     frame: CGRectMake(x0, 110, colorViewWidth, colorViewHeight)];
    _view4 = [[ColorView alloc] initWithHex: @"FF6B6B"
                                     alpha: 1.0
                                     frame: CGRectMake(x0, 160, colorViewWidth, colorViewHeight)];
    _view5 = [[ColorView alloc] initWithHex: @"C44D58"
                                     alpha: 1.0
                                     frame: CGRectMake(x0, 210, colorViewWidth, colorViewHeight)];
    
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    [self.view addSubview:_view3];
    [self.view addSubview:_view4];
    [self.view addSubview:_view5];
}



@end
