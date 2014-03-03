/*
 * Copyright 2010-present Facebook.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SLViewController.h"
#import "AppDelegate.h"
#import "AfterLoggedInViewController.h"
#import "AFLinkedInOAuth1Client.h"
#import "AFXMLRequestOperation.h"
#import <LVTwitterOAuthClient.h>
#import "SA_OAuthTwitterEngine.h"
#import "SBJson.h"
#import "Constants.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2SignIn.h"
#import "TMAPIClient.h"

@interface SLViewController ()
{
    
    NSString *twittername;

}

@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
@property (strong, nonatomic) IBOutlet UITextView *textNoteOrLink;
@property (retain, NS_NONATOMIC_IOSONLY) ACAccount *account;


@end

@implementation SLViewController
@synthesize _engine,appdelegate;

- (void)viewDidLoad {
    self.title=@"Social Login";
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"ID %@",appdelegate.kClientID);
    
    
    [super viewDidLoad];
    

    if(!_engine)
    {
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
        _engine.consumerKey    = kOAuthConsumerKey;
        _engine.consumerSecret = kOAuthConsumerSecret;
    }
    UIButton *facebookbtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 108, 280, 40)];
    facebookbtn.backgroundColor=[UIColor blueColor];
    [facebookbtn setBackgroundImage:[UIImage imageNamed:@"facebook-login.png"] forState:UIControlStateNormal];
    [facebookbtn addTarget:self action:@selector(fbLogin) forControlEvents:UIControlEventTouchUpInside];
    [facebookbtn setTitle:@"Facebook" forState:UIControlStateNormal];
    [facebookbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:facebookbtn];
    
   
    
    UIButton *linkedInBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 188, 280, 40)];
    //[linkedInBtn setBackgroundImage:[UIImage imageNamed:@"images.jpg"] forState:UIControlStateNormal];
    linkedInBtn.backgroundColor=[UIColor blueColor];
    [linkedInBtn addTarget:self action:@selector(linkedinLogin) forControlEvents:UIControlEventTouchUpInside];
    [linkedInBtn setTitle:@"Login with LinkedIn" forState:UIControlStateNormal];
    [linkedInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:linkedInBtn];

    
    UIButton *twitterLogin=[[UIButton alloc]initWithFrame:CGRectMake(20, 268, 280, 40)];
    [twitterLogin setBackgroundImage:[UIImage imageNamed:@"twitter-login.png"] forState:UIControlStateNormal];
    twitterLogin.backgroundColor=[UIColor clearColor];
    [twitterLogin addTarget:self action:@selector(twitterLogin) forControlEvents:UIControlEventTouchUpInside];
    [twitterLogin setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:twitterLogin];
    
    UIButton *google=[[UIButton alloc]initWithFrame:CGRectMake(20, 348, 280, 40)];
    [google setBackgroundImage:[UIImage imageNamed:@"login-google.png"] forState:UIControlStateNormal];
    google.backgroundColor=[UIColor clearColor];
    [google addTarget:self action:@selector(loginInToGoogle) forControlEvents:UIControlEventTouchUpInside];
    [google setTitle:@"Google" forState:UIControlStateNormal];
    [google setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:google];
    
    UIButton *tumblr=[[UIButton alloc]initWithFrame:CGRectMake(20, 428, 280, 40)];
    //[google setBackgroundImage:[UIImage imageNamed:@"login-google.png"] forState:UIControlStateNormal];
    tumblr.backgroundColor=[UIColor purpleColor];
    [tumblr addTarget:self action:@selector(TumblrAuth) forControlEvents:UIControlEventTouchUpInside];
    [tumblr setTitle:@"Tumblr" forState:UIControlStateNormal];
    [tumblr setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:tumblr];
    
    
    if(!_engine){
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
        _engine.consumerKey    = kOAuthConsumerKey;
        _engine.consumerSecret = kOAuthConsumerSecret;
        
    }


}


/*** Facebook Login ***/

-(void)fbLogin
{
    if (facebook == nil)
    {
        facebook = [[Facebook alloc] initWithAppId:kFacebookAppID];
    }
    NSArray* permissions =  [NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access",@"read_friendlists", nil];
    [facebook authorize:permissions delegate:self];
}
- (BOOL) takeScreenshot
{
    NSMutableDictionary* params = [ NSMutableDictionary dictionaryWithObjectsAndKeys:@"id,name,link,gender,last_name,first_name",@"fields",nil];
    //    [facebook requestWithGraphPath:@"me/photos" andParams:params andHttpMethod:@"POST" andDelegate:self];
    [facebook requestWithGraphPath:@"me"
                         andParams:params andDelegate:self];
    return YES;
    
}
- (void)fbDidLogin
{
    isFBLogged = YES;
    [self takeScreenshot];
}
-(void)fbDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        
    }
    else
    {
        
    }
}
- (void)fbDidLogout
{
    isFBLogged = NO;
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
- (void)showWithCustomView:(NSString*)str
{
    
}
- (void)request:(FBRequest *)request didLoad:(id)result
{
    isFBLogged=NO;
    NSString *facebookid=facebook.accessToken;
    NSLog(@"facebookarray %@",facebookid);
   // myfacebookid=[result objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[result objectForKey:@"id"] forKey:@"myafacebookid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // [self facebookod:facebookid];
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    //[message setString:@"Error. Please try again."];
    //menuView.hidden = NO;
    NSLog(@"error %@",[error description]);
}

#pragma mark -
#pragma mark FBDialogDelegate
- (void)dialogDidComplete:(FBDialog *)dialog
{
    NSLog(@"publish successfully");
    if (isFBLogged)
    {
        [facebook logout:self];
    }
    else
    { // then the code above inside the else
        [facebook logout:self];
    }
}




/*** Twitter Login Methods ***/

-(void)twitterLogin
{
    if(![_engine isAuthorized])
    {
        UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
       [self presentViewController:controller animated:YES completion:nil];
        
    }
    else if([_engine isAuthorized])
    {
        NSLog(@"Twitter Login");
        //[self twitterLoginMethod];
        AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}


#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
    twittername=username;
    NSLog(@"ScreenName for %@", twittername);
    [self twitterLoginMethod];
    
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}


#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}


-(void)twitterLoginMethod
{
    
    AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}


//AlertView
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}






/*** LinkedIn Login Methods***/

- (void)linkedinLogin {
    AFLinkedInOAuth1Client *oauthClient = [[AFLinkedInOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.linkedin.com/"]
                                                                                      key:kLinkedInAuthConsumerKey
                                                                                   secret:kLinkedInAuthConsumerSecret];
    
    [oauthClient authorizeUsingOAuthWithRequestTokenPath:@"uas/oauth/requestToken"
                                   userAuthorizationPath:@"uas/oauth/authorize"
                                             callbackURL:[NSURL URLWithString:@"MSS://com.mss.MSSSocialLogin"]
                                         accessTokenPath:@"uas/oauth/accessToken"
                                            accessMethod:@"GET"
                                                   scope:nil
                                                 success:^(AFOAuth1Token *accessToken, id responseObject) {
                                                     NSLog(@"access token %@",accessToken);
                                                     AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
                                                     [self.navigationController pushViewController:viewController animated:YES];
                                                     [oauthClient getPath:@"v1/people/~:(id,first-name,last-name,headline)" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                         NSLog(@"JSON RESPONSE: %@", responseObject);
                                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                         NSLog(@"ERROR: %@", error);
                                                     }];
                                                     
                                                 } failure:^(NSError *error) {
                                                     NSLog(@"Error: %@", error);
                                                 }];
//    AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark Template generated code

- (void)viewDidUnload
{
    self.buttonLoginLogout = nil;
    self.textNoteOrLink = nil;

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

}

/*** Google Login Methods ***/

- (void)loginInToGoogle
{
    GTMOAuth2Authentication * auth = nil;
    
    NSURL * tokenURL = [NSURL URLWithString:TokenURL];
    NSString * redirectURI = @"urn:ietf:wg:oauth:2.0:oob";
    
    auth = [GTMOAuth2Authentication
            authenticationWithServiceProvider:ServiceProvicer
            tokenURL:tokenURL
            redirectURI:redirectURI
            clientID:ClientID
            clientSecret:ClientSecret];
    
    auth.scope = @"https://www.googleapis.com/auth/plus.me";
    
    GTMOAuth2ViewControllerTouch * viewController =
    [[GTMOAuth2ViewControllerTouch alloc]
     initWithAuthentication:auth
     authorizationURL:[NSURL URLWithString:AuthURL]
     keychainItemName:KeychainName
     delegate:self
     finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewController:(GTMOAuth2ViewControllerTouch * )viewController
      finishedWithAuth:(GTMOAuth2Authentication * )auth
                 error:(NSError * )error
{
    NSString * accessToken = auth.accessToken;
    
    NSLog(@"auth access token: %@", accessToken);
    
    //[self.navigationController popToViewController:self animated:NO];
    if (error != nil) {
        
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"Error"
         message:[error localizedDescription]
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
        
        [alert show];
    } else {
        
        AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}


/*** Tumblr Login Methods ***/

- (void)TumblrAuth {
    [[TMAPIClient sharedInstance] authenticate:@"MSS://com.mss.MSSSocialLogin" callback:^(NSError *error) {
        
        if (!error)
            NSLog(@"Authentication failed: %@ %@", error, [error description]);
        else
            NSLog(@"Authentication successful!");
        
    }];
    AfterLoggedInViewController *viewController = [[AfterLoggedInViewController alloc]initWithNibName:@"AfterLoggedInViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

    }


@end
