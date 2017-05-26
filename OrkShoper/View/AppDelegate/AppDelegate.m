//
//  AppDelegate.m
//  OrkShoper
//
//  Created by Келбин on 20.04.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NewsController.h"
#import "NewsCellsController.h"
#import "MarketController.h"
#import "MapController.h"
@interface AppDelegate ()

@end
@import GoogleMaps;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    ViewController *maincon = [[ViewController alloc] init];
    NewsController *news = [[NewsController alloc]init];
    MapController *map = [[MapController alloc]init];
    MarketController *market = [[MarketController alloc] init];
    UINavigationController *navcontroller = [[UINavigationController alloc] initWithRootViewController:maincon];
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:news];
    UINavigationController *mapnavcon = [[UINavigationController alloc] initWithRootViewController:map];
    UINavigationController *marketcon = [[UINavigationController alloc] initWithRootViewController:market];
    NSArray *controllers = [NSArray arrayWithObjects:navcontroller,navcon,mapnavcon,marketcon,nil];
    tabBar.viewControllers = controllers;
    navcontroller.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"home.png"] tag:0];
    navcon.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"newspaper.png"] tag:1];
    mapnavcon.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"map.png"] tag:2];
    marketcon.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"shop.png"] tag:3];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    [GMSServices provideAPIKey:@"AIzaSyCOunjbapTOY35NXTPZ90GxiesmHqu7XM8"];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
