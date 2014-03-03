//
//  AppDelegate.h
//  MSSSocialLogin
//
//  Created by ravi kumar on 19/02/14.
//  Copyright (c) 2014 masterSoftwareSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SLViewController *viewController;


@property (nonatomic,retain)  NSString *kAppId;
@property (nonatomic,retain)NSString *kClientID;

@end
