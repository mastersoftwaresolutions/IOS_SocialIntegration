//
//  AfterLoggedInViewController.h
//  MSSSocialLogin
//
//  Created by ravi kumar on 19/02/14.
//  Copyright (c) 2014 masterSoftwareSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SLViewController.h"
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
@class SA_OAuthTwitterEngine;

@interface AfterLoggedInViewController : UIViewController<SA_OAuthTwitterControllerDelegate>
@property(nonatomic,retain)SLViewController *SL;
@property(nonatomic,retain) AppDelegate *appdelegate;
@end
