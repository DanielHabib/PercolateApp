//
//  CoreDataAPI.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Post.h"
@interface CoreDataAPI : NSObject

+(NSManagedObjectContext *)grabGlobalManagedObjectContext;
+(NSManagedObjectModel *)grabGlobalyManagedObjectModel;
+(NSPersistentStoreCoordinator *)grabGloballyPersistentStoreCoordinator;
+(BOOL)attemptToInsertPost:(Post *)post;
+(NSArray *)fetchStoredCoffeeArray;
+(NSArray *)fetchSpecificCoffeePost:(NSString *)name;
+(void)updateCoreDataStoreWithPostArray;
+(void)preventCacheFromGettingTooLarge;
@end
