//
//  MantleAPI.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//
#import "MantleAssembly.h"
#import "MantleAPI.h"
@implementation MantleAPI


+(NSMutableArray *)grabGlobalCoffeeList{
    MantleAssembly *assembly = [MantleAssembly sharedManager];
    return assembly.coffeeListArray;
}



+ (NSArray *)deserializeCoffeePostFromJSON:(NSArray *)coffeeJSON
{
    NSError *error;
    NSArray *coffeePost = [MTLJSONAdapter modelsOfClass:[CoffeePost class] fromJSONArray:coffeeJSON error:&error];
    if (error) {
        NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
        return nil;
    }
    
    return coffeePost;
}
+ (NSArray *)deserializeCoffeePostFromNSData:(NSData *)jsonFormatData
{
    NSError *error;
    NSArray *appInfosJSON = [NSJSONSerialization JSONObjectWithData:jsonFormatData options:0 error:&error];
    if (error) {
        NSLog(@"Couldn't deserealize app info data into JSON from NSData: %@", error);
        return nil;
    }
    
    return [MantleAPI deserializeCoffeePostFromJSON:appInfosJSON];
}


+ (NSData *)serializeCoffeePostToNSData:(NSArray *)coffeeArray
{
    NSArray *coffeeJSON = [MTLJSONAdapter JSONArrayFromModels:coffeeArray];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:coffeeJSON options:0 error:&error];
    if (error) {
        NSLog(@"Couldn't turn coffee info JSON into NSData. JSON: %@, \n\n Error: %@", coffeeJSON, error);
        return nil;
    }
    
    return jsonData;
}
@end

