//
//  DemoColor2.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "DemoColor2.h"
#import "ColorView2.h"

@interface DemoColor2 ()

@end

@implementation DemoColor2
{
    NSArray *_cpArray;
    ColorView2 *_view1, *_view2, *_view3, *_view4, *_view5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray* cp1 = @[@"ECD078", @"D95B43", @"C02942", @"542437", @"53777A"];
    NSArray* cp2 = @[@"00A0B0", @"6A4A3C", @"CC333F", @"EB6841", @"EDC951"];
    NSArray* cp3 = @[@"594F4F", @"547980", @"45ADA8", @"9DE0AD", @"E5FCC2"];
    NSArray* cp4 = @[@"FF9900", @"424242", @"E9E9E9", @"BCBCBC", @"3299BB"];
    NSArray* cp5 = @[@"5E412F", @"FCEBB6", @"78C0A8", @"F07818", @"F0A830"];
    NSArray* cp6 = @[@"FAD089", @"FF9C5B", @"F5634A", @"ED303C", @"3B8183"];
    
    _cpArray = @[cp1, cp2, cp3, cp4, cp5, cp6];
    
    CGFloat colorViewWidth = 200.0;
    CGFloat colorViewHeight = 40.0;
    CGFloat x0 = (self.view.bounds.size.width - colorViewWidth) * 0.5;
    
    _view1 = [[ColorView2 alloc] initWithHex: @"556270"
                                      alpha: 1.0
                                      frame: CGRectMake(x0, 10, colorViewWidth, colorViewHeight)];
    _view2 = [[ColorView2 alloc] initWithHex: @"4ECDC4"
                                      alpha: 1.0
                                      frame: CGRectMake(x0, 60, colorViewWidth, colorViewHeight)];
    _view3 = [[ColorView2 alloc] initWithHex: @"C7F464"
                                      alpha: 1.0
                                      frame: CGRectMake(x0, 110, colorViewWidth, colorViewHeight)];
    _view4 = [[ColorView2 alloc] initWithHex: @"FF6B6B"
                                      alpha: 1.0
                                      frame: CGRectMake(x0, 160, colorViewWidth, colorViewHeight)];
    _view5 = [[ColorView2 alloc] initWithHex: @"C44D58"
                                      alpha: 1.0
                                      frame: CGRectMake(x0, 210, colorViewWidth, colorViewHeight)];
    
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    [self.view addSubview:_view3];
    [self.view addSubview:_view4];
    [self.view addSubview:_view5];
    
    [self performSelectorOnMainThread:@selector(animateColor:)
                           withObject:[NSNumber numberWithInt:0]
                        waitUntilDone:true];
}

- (void) animateColor:(NSNumber *)cpIndex {
    int index = [cpIndex intValue];

    [UIView animateWithDuration:3.0
                     animations:^{
                         NSArray *cp = _cpArray[index];
                         _view1.hex = cp[0];
                         _view2.hex = cp[1];
                         _view3.hex = cp[2];
                         _view4.hex = cp[3];
                         _view5.hex = cp[4];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0
                                          animations:^{
                                              [_view1 fadeOut];
                                              [_view2 fadeOut];
                                              [_view3 fadeOut];
                                              [_view4 fadeOut];
                                              [_view5 fadeOut];
                                          } completion:^(BOOL finished) {
                                              int nextIndex = (index + 1) % _cpArray.count;
                                              [self animateColor:[NSNumber numberWithInt:nextIndex]];
                                          }];
                     }];
}

@end