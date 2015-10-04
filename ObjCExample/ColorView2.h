//
//  ColorView2.h
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorView2 : UIView

@property (nonatomic, strong) NSString *hex;

- (instancetype) initWithHex:(NSString *)hex alpha:(CGFloat)alpha frame:(CGRect)frame;
- (void) fadeOut;

@end
