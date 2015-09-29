//
//  CustomSwitch.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/29/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "CustomSwitch.h"

@implementation CustomSwitch
{
    UIButton *_buttonON;
    UIButton *_buttonOFF;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 143, 64)];
    
    _buttonON = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74, 64)];
    _buttonOFF = [[UIButton alloc] initWithFrame:CGRectMake(74, 0, 69, 64)];
    
    [_buttonON addTarget:self action:@selector(pressON) forControlEvents:UIControlEventTouchUpInside];
    [_buttonOFF addTarget:self action:@selector(pressOFF) forControlEvents:UIControlEventTouchUpInside];
    
    self.value = false;
    
    [self addSubview:_buttonON];
    [self addSubview:_buttonOFF];
    
    return self;
}

- (void) pressON {
    self.value = true;
}

- (void) pressOFF {
    self.value = false;
}

- (BOOL) getValue {
    return _value;
}

- (void) setValue:(BOOL)value {
    _value = value;
    if (_value) {
        [_buttonON setImage:[UIImage imageNamed:@"OnWhite"] forState:normal];
        [_buttonOFF setImage:[UIImage imageNamed:@"OffWhite"] forState:normal];
    }
    else {
        [_buttonON setImage:[UIImage imageNamed:@"OnBlack"] forState:normal];
        [_buttonOFF setImage:[UIImage imageNamed:@"OffBlack"] forState:normal];
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
