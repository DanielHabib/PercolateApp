//
//  AFNetworkingAPI.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "MainTableViewController.h"

@interface AFNetworkingAPI : NSObject
+(NSURL *)grabBaseURL;
+(NSString *)grabAPIKey;
+(void)FetchFullListFromServerIntoVC:(MainTableViewController *)myVC;


@end
