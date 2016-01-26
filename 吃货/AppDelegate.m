//
//  AppDelegate.m
//  吃货
//
//  Created by qingyun on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"



@interface AppDelegate ()<UITabBarControllerDelegate>


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tab = [[UITabBarController alloc]init];
    
    tab.delegate = self;
    
    
    FirstViewController *firstvc = [[FirstViewController alloc]init];
    UINavigationController *Firstnav = [[UINavigationController alloc]initWithRootViewController:firstvc];
    firstvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"2"] tag:1];
    
    SecondViewController *secondvc =[[SecondViewController alloc]init];
    UINavigationController *Secondnav = [[UINavigationController alloc]initWithRootViewController:secondvc];
    secondvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"菜谱" image:[UIImage imageNamed:@"3"] tag:2];
    
    ThirdViewController *thirdvc = [[ThirdViewController alloc]init];
    UINavigationController *Thirdnav = [[UINavigationController alloc]initWithRootViewController:thirdvc];
    thirdvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"精选" image:[UIImage imageNamed:@"1"] tag:3];
    
    FourViewController *fourvc = [[FourViewController alloc]init];
    UINavigationController *Fournav = [[UINavigationController alloc]initWithRootViewController:fourvc];
    fourvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"专辑" image:[UIImage imageNamed:@"4"] tag:4];


    
    
    NSArray *arr = @[Firstnav,Secondnav,Thirdnav,Fournav];
    
    
    
    tab.viewControllers = arr;
    
    self.window.rootViewController = tab;
    
    [self.window makeKeyAndVisible];
    

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
