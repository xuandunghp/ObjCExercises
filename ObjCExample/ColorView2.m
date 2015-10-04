//
//  ColorView2.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "ColorView2.h"
#import "HexColor.h"

@implementation ColorView2
{
    UILabel *_label;
}

- (instancetype) initWithHex: (NSString*) hex
                       alpha: (CGFloat) alpha
                       frame: (CGRect) rect {
    self = [super initWithFrame:rect];
    self.backgroundColor = [HexColor colorWithHex:hex
                                            alpha:alpha];

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
    _hex = hex;
    self.backgroundColor = [HexColor colorWithHex:hex alpha:1.0];
    _label.text = hex;
    _label.textColor = [UIColor blackColor];
}

- (void) fadeOut {
    self.backgroundColor = [HexColor colorWithHex:self.hex
                                            alpha:0.1];
    _label.textColor = [HexColor colorWithHex:@"000000"
                                       alpha:0.1];
}

@end
