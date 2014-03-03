//
//  AppDelegate.m
//  MSSSocialLogin
//
//  Created by ravi kumar on 19/02/14.
//  Copyright (c) 2014 masterSoftwareSolutions. All rights reserved.
//

#import "AppDelegate.h"
#import "SLViewController.h"
#import "AFLinkedInOAuth1Client.h"

#import "AFNetworkActivityIndicatorManager.h"
#import "Constants.h"
#import "TMAPIClient.h"

@implementation AppDelegate
@synthesize kAppId,kClientID;


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[TMAPIClient sharedInstance] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    // attempt to extract a token from the url
    
//    kClientID=@"942690114069-jmp86pmopu1ojap02t2370opveagkr0j.apps.googleusercontent.com";
//    [[NSUserDefaults standardUserDefaults] setObject:kClientID forKey:@"googleKey"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [GPPSignIn sharedInstance].clientID = kClientID;

    return YES;
   
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[SLViewController alloc] initWithNibName:@"SLViewController_iPhone" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:_viewController];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController =nav;
    [self.window makeKeyAndVisible];
    
    [TMAPIClient sharedInstance].OAuthConsumerKey = kTumblrAuthConsumerKey;
    [TMAPIClient sharedInstance].OAuthConsumerSecret = kTumblrAuthConsumerSecret;
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     
}

@end
