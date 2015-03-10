//
//  AppDelegate.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "APICollection.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    MainTableViewController *vc = [[MainTableViewController alloc]init];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = vc ;

    _ManagedObjectContext = [CoreDataAPI grabGlobalManagedObjectContext];
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    [CoreDataAPI updateCoreDataStoreWithPostArray];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
