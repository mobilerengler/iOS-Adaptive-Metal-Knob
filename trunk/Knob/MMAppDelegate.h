//
//  MMAppDelegate.h
//  Knob
//
//  Created by Ryan Engle on 6/13/12.
//  Copyright (c) 2012 Ryan Engle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMViewController;

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MMViewController *viewController;

@end
