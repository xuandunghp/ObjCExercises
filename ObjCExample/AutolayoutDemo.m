//
//  AutolayoutDemo.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/6/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "AutolayoutDemo.h"

@interface AutolayoutDemo ()

@end

@implementation AutolayoutDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationChanged)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateViewSize];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void) deviceOrientationChanged {
    [self updateViewSize];
}

- (void) updateViewSize {
    UIView *view1 = [self.view subviews][0];
    UIView *view2 = [self.view subviews][1];
    
    UILabel *label1 = [view1 subviews][0];
    UILabel *label2 = [view2 subviews][0];
    
    label1.text = [NSString stringWithFormat:@"View 1: %0.1f x %0.1f", view1.bounds.size.width, view1.bounds.size.height];
    label2.text = [NSString stringWithFormat:@"View 2: %0.1f x %0.1f", view2.bounds.size.width, view2.bounds.size.height];
}


@end
