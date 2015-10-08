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
//                                    @{TITLE: @"Image Skewer", CLASS: @"ImageSkewer"},
//                                    @{TITLE: @"Customized Switch", CLASS: @"CustomizedUISwitchDemo"}
//                          ]};

//    NSDictionary* collectionDemo = @{SECTION: @"Collection",
//                                     MENU: @[
//                                             @{TITLE: @"NSArray truy vấn - Barcelona Rotation", CLASS: @"BarcelonaRotation"},
//                                             @{TITLE: @"NSArray truy vấn - Unique elements", CLASS: @"UniqueElementFromArrayDemo"},
//                                             @{TITLE: @"NSArray gọi hàm xử lý từng phần tử", CLASS: @"IntegerToText"}
//                                             @{TITLE: @"C Array vs NSArray - 1", CLASS: @"Exercise1"},
//                                             @{TITLE: @"C Array vs NSArray - 2", CLASS: @"Exercise2"},
//                                             @{TITLE: @"NSDictionary", CLASS: @"DictionaryDemo"},
//                                             @{TITLE: @"NSMutable Array Category", CLASS: @"WordCount"}
//                                            ]
//                                    };

    
//    NSDictionary *advancedUIView = @{SECTION: @"Advanced UIView", MENU: @[
//                                             @{TITLE: @"Swift to Objective C - Basic View", CLASS: @"BasicView"},
//                                             @{TITLE: @"Swift to Objective C - Chess View", CLASS: @"ChessView"},
//                                             @{TITLE: @"Camp fire", CLASS: @"CampFire"},
//                                             @{TITLE: @"Nested square", CLASS: @"NestedSquare"},
//                                             @{TITLE: @"Flying bird", CLASS: @"FlyingBird"},
//                                             @{TITLE: @"Swing ship", CLASS: @"SwingShip"},
//                                             @{TITLE: @"Star Field", CLASS: @"StarField"},
//                                             @{TITLE: @"Hex color #2", CLASS: @"DemoColor1"},
//                                             @{TITLE: @"Hex color #3", CLASS: @"DemoColor2"},
//                                             @{TITLE: @"Rolling Ball", CLASS: @"RollingBall"},
//                                             @{TITLE: @"Earth around sun", CLASS: @"EarthAroundSun"},
//                                             @{TITLE: @"Drop ball", CLASS: @"DropBall"}
//                                             ]
//                                     };
    
//    NSDictionary* advancedAutolayout = @{SECTION: @"Advanced Autolayout", MENU: @[
//                                                 @{TITLE: @"Get size of UIView in Autolayout", CLASS: @"AutolayoutDemo"}
//                                                 ]
//                                         };
    
    NSDictionary* UIScrollView = @{SECTION: @"UIScrollView", MENU: @[
                                           @{TITLE: @"Basic UIScrollView", CLASS:@"BasicScrollView"},
                                           @{TITLE: @"UIScrollView with UIToolBar, UIBarButtonItem", CLASS:@"ScaleWithSlider"},
                                           @{TITLE: @"ContentSize and bounce", CLASS:@"ContentSizeBasic"},
                                           @{TITLE: @"Tap to zoom", CLASS:@"PhotoListTableViewController"},
                                           @{TITLE: @"Paging ScrollView", CLASS:@"SimpleScroll"}
                                           ]
                                   };
                                   
    
    mainScreen.menu = @[UIScrollView];
    mainScreen.title = @"Bootstrap App";
    mainScreen.about = @"This is demo bootstrap demo app. It is collection of sample code of AVFoundation";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
