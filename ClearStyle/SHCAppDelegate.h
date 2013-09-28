//
//  SHCAppDelegate.h
//  ClearStyle
//
//  Created by Fahim Farook on 22/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
@class SHCViewController,SHCListViewController;

@interface SHCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SHCViewController *viewController;

+ (NSInteger)OSVersion;
@end
