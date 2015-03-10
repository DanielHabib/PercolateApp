//
//  AFNetworkingAPI.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//
#import "AFNetworkingAPI.h"
#import "AFNetworkingAssembly.h"
#import "MantleAPI.h"


@implementation AFNetworkingAPI

+(NSString *)grabAPIKey{
    AFNetworkingAssembly* AFnet = [AFNetworkingAssembly sharedManager];
    return AFnet.apiKey;
}
+(NSURL *)grabBaseURL{
    AFNetworkingAssembly *AFnet = [AFNetworkingAssembly sharedManager];
    return AFnet.baseURL;
}

+(void)FetchFullListFromServerIntoVC:(MainTableViewController *)myVC{
    
    NSString *path = @"/api/coffee/?api_key=WuVbkuUsCXHPx3hsQzus4SE";
    NSURL *baseURL = [AFNetworkingAPI grabBaseURL] ;
    baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,path]];
    //NSString *apiKey = [AFNetworkingAPI grabAPIKey];
   // NSString *apiKeyHeader = [NSString stringWithFormat:@"api_key=%@",apiKey];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //I expected this method to work for setting the auth key, I was unable to get it to work so I was forced to put it in the url as a get parameter
    //[manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSArray *result = [MantleAPI deserializeCoffeePostFromJSON:responseObject];
        NSMutableArray *array = [NSMutableArray arrayWithArray:result];
        NSMutableArray * coffeeList = [MantleAPI grabGlobalCoffeeList];

        for (CoffeePost* item in array) {
            ;
            if (![item.name isEqualToString:@""]) {
                [coffeeList addObject:item];
            }
            
        }
        NSLog(@"complete");
        [myVC globalListPopulated];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable To Connect to the Coffee API"
                                                            message:@"Sorry, try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    

}
@end
