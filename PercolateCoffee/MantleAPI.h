//
//  MantleAPI.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <Mantle/Mantle.h>
#import "CoffeePost.h"

@interface MantleAPI : NSObject

+ (NSData *)serializeCoffeePostToNSData:(NSArray *)coffeeArray;

+ (NSArray *)deserializeCoffeePostFromNSData:(NSData *)jsonFormatData;

+ (NSArray *)deserializeCoffeePostFromJSON:(NSArray *)coffeeJSON;

+(NSMutableArray *)grabGlobalCoffeeList;


@end
