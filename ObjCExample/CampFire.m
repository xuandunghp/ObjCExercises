//
//  CampFire.m
//  ObjCExample
//
//  Created by Dzung Tran on 9/30/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "CampFire.h"

@interface CampFire ()

@end

@implementation CampFire

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self burnFire];
    
}

- (void) burnFire {
    UIImageView *fire = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:17];
    
    for (int i = 1; i < 18; i++) {
        NSString *fileName;
    
        if (i < 10) {
            fileName = [NSString stringWithFormat:@"campFire0%d.gif", i];
        }
        else {
            fileName = [NSString stringWithFormat:@"campFire%d.gif", i];
        }
        
        [images addObject:[UIImage imageNamed:fileName]];
    }
    
    fire.animationImages = images;
    fire.animationDuration = 1;
    fire.animationRepeatCount = 0;
    
    [self.view addSubview:fire];
    [fire startAnimating];
}


@end
