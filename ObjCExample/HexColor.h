//
//  HexColor.h
//  ObjCExample
//
//  Created by Dzung Tran on 10/4/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HexColor : UIColor

+ (instancetype) colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

@end
