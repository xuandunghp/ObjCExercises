//
//  ColorView.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ColorView.h"
#import "UIColor+Extend.h"

@implementation ColorView
{
    UILabel *_label;
}

- (instancetype) initWithHex: (NSString*) hex
                       alpha: (CGFloat) alpha
                       frame: (CGRect) rect {
    self = [super initWithFrame:rect];
    self.backgroundColor = [UIColor colorWithHex:hex alpha:alpha];
    
    if (rect.size.width > 150 && rect.size.height > 30) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width - 10.0, 30)];
        _label.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = hex;
        [self addSubview:_label];
    }
    
    return self;
}

//Setter function
- (void) setHex:(NSString *)hex {
    self.backgroundColor = [UIColor colorWithHex:hex alpha:1.0];
    _label.text = hex;
    _label.textColor = [UIColor blackColor];
}
@end
