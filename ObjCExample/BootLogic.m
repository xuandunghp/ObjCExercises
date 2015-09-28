//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"


@implementation BootLogic
+ (void) boot: (UIWindow*) window
{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];

    //--------- From this line, please customize your menu data -----------
//    NSDictionary* basic = @{SECTION: @"Basic", MENU: @[
//                                    @{TITLE: @"Function", CLASS: @"DemoFunction"},
//                                    @{TITLE: @"Selector", CLASS: @"DemoSelector"},
//                                    @{TITLE: @"Basic Slider", CLASS: @"BasicSlider"},
//                                    @{TITLE: @"Advanced Slider 1", CLASS: @"AdvancedSlider1"},
//                                    @{TITLE: @"Advanced Slider 2", CLASS: @"AdvancedSlider2"},
//                                    @{TITLE: @"Image Skewer", CLASS: @"ImageSkewer"}
//                          ]};
    NSDictionary* collectionDemo = @{SECTION: @"Collection",
                                     MENU: @[
                                             //@{TITLE: @"NSArray truy vấn - Barcelona Rotation", CLASS: @"BarcelonaRotation"},
                                             //@{TITLE: @"NSArray truy vấn - Unique elements", CLASS: @"UniqueElementFromArrayDemo"},
                                             //@{TITLE: @"NSArray gọi hàm xử lý từng phần tử", CLASS: @"IntegerToText"}
                                             //@{TITLE: @"C Array vs NSArray - 1", CLASS: @"Exercise1"},
                                             //@{TITLE: @"C Array vs NSArray - 2", CLASS: @"Exercise2"},
                                             @{TITLE: @"NSDictionary", CLASS: @"DictionaryDemo"},
                                             @{TITLE: @"NSMutable Array Category", CLASS: @"WordCount"}
                                            ]
                                    };
    
//    NSDictionary* intermediate = @{SECTION: @"Intermediate", MENU: @[
//                                    @{TITLE: @"Inter B", CLASS: @"InterB"}
//                                  ]};
//    NSDictionary* advanced = @{SECTION: @"Advanced", MENU: @[
//                                    @{TITLE: @"Advanced C", CLASS: @"AdvancedC"}
//                             ]};
    
    mainScreen.menu = @[collectionDemo];
    mainScreen.title = @"Bootstrap App";
    mainScreen.about = @"This is demo bootstrap demo app. It is collection of sample code of AVFoundation";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
