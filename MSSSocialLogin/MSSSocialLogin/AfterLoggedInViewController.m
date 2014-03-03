//
//  AfterLoggedInViewController.m
//  MSSSocialLogin
//
//  Created by ravi kumar on 19/02/14.
//  Copyright (c) 2014 masterSoftwareSolutions. All rights reserved.
//

#import "AfterLoggedInViewController.h"
#import "SLViewController.h"
#import "SA_OAuthTwitterEngine.h"


@interface AfterLoggedInViewController ()
@property (nonatomic,retain) SA_OAuthTwitterController *aengin;
@end

@implementation AfterLoggedInViewController
@synthesize appdelegate,aengin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"Login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    /*** Home button ***/
    UIButton *homeBtn1=[[UIButton alloc]initWithFrame:CGRectMake(20, 20, 60, 40)];
    homeBtn1.backgroundColor=[UIColor clearColor];
    [homeBtn1 addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [homeBtn1 setTitle:@"Logout" forState:UIControlStateNormal];
    [homeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:homeBtn1];
    _SL=[[SLViewController alloc] init];



    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)backToHome{
   [self clickToLogout];
//    
////    SLViewController *welcome= [[SLViewController alloc]initWithNibName:@"SLViewController_iPhone" bundle:Nil];
////    [self.navigationController pushViewController:welcome animated:YES];
//    
//    if (appdelegate.session.isOpen) {
//        // if a user logs out explicitly, we delete any cached token information, and next
//        // time they run the applicaiton they will be presented with log in UX again; most
//        // users will simply close the app or switch away, without logging out; this will
//        // cause the implicit cached-token login to occur on next launch of the application
//        
//        [appdelegate.session closeAndClearTokenInformation];
//        
//    }
//
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) clickToLogout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
    
    [self clearTwitterToken];
    
}
-(void)clearTwitterToken
{
    SA_OAuthTwitterEngine *_engine = nil;
    [_engine clearAccessToken];
    [_engine clearsCookies];
    [_SL._engine clearAccessToken];
    [_SL._engine clearsCookies];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authData"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"authName"];
    
    NSLog(@"authName%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"authName"]);
    NSLog(@"authData%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"authData"]);
    _engine=nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}
@end
