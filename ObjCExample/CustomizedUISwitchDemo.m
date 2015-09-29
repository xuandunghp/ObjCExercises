//
//  CustomizedUISwitchDemo.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/29/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "CustomizedUISwitchDemo.h"
#import "CustomSwitch.h"

@interface CustomizedUISwitchDemo ()

@end

@implementation CustomizedUISwitchDemo
{
    CustomSwitch *_mySwitch;
    UIImageView *_led;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    _led = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ledOFF"]];
    _led.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.3);
    
    [self.view addSubview:_led];
    
    
    _mySwitch = [[CustomSwitch alloc] initWithFrame:CGRectMake(0, 0, 216, 80)];
    _mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
    [_mySwitch addTarget:self
                  action:@selector(switchChange:)
        forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_mySwitch];
}

- (void) switchChange:(CustomSwitch *)customSwitch {
    if (_mySwitch.value) {
        [_led setImage:[UIImage imageNamed:@"ledON"]];
    }
    else {
        [_led setImage:[UIImage imageNamed:@"ledOFF"]];
    }
}

@end
