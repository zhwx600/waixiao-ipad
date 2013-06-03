//
//  AppDelegate.m
//  LiDaXin-iPad
//
//  Created by apple on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "HallOneViewController.h"
#import "HallTwoViewController.h"
#import "HallThreeViewController.h"

#import "RoomViewController.h"
#import "DetailParamViewController.h"
#import "OtherOptionViewController.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize m_hallOne,m_hallTwo,m_hallThree;
@synthesize navigationController;
@synthesize m_bedRoomViewController;
@synthesize m_otherView;
@synthesize m_detailView;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
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


-(void) entryHallOne
{
    if (!self.m_hallOne) {
        self.m_hallOne = [[HallOneViewController alloc] init];
    }
    self.m_hallOne.m_bFreshImageBlock = YES;
    [self.navigationController pushViewController:self.m_hallOne animated:YES];
    
}
-(void) entryHallTwo
{
    if (!self.m_hallTwo) {
        self.m_hallTwo = [[HallTwoViewController alloc] init];
    }
    self.m_hallTwo.m_bFreshImageBlock = YES;
    [self.navigationController pushViewController:self.m_hallTwo animated:YES];
}

-(void) entryHallThree
{
    if (!self.m_hallThree) {
        self.m_hallThree = [[HallThreeViewController alloc] init];
    }
    self.m_hallThree.m_bFreshImageBlock = YES;
    [self.navigationController pushViewController:self.m_hallThree animated:YES];
    
}


-(void) entryBedRoom
{
    if (!self.m_bedRoomViewController) {
        self.m_bedRoomViewController = [[RoomViewController alloc] init];
    }
    [self.navigationController pushViewController:self.m_bedRoomViewController animated:YES];
}


-(void) entryDetail
{
    if (!self.m_detailView) {
        self.m_detailView = [[DetailParamViewController alloc] init];
    }
    [self.navigationController pushViewController:self.m_detailView animated:YES];
}

-(void) entryOther
{
    if (!self.m_otherView) {
        self.m_otherView = [[OtherOptionViewController alloc] init];
    }
    [self.navigationController pushViewController:self.m_otherView animated:YES];
}


@end
