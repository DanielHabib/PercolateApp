//
//  CoreDataAPI.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "CoreDataAPI.h"
#import "CoreDataAssembly.h"
#import "AFNetworkingAPI.h"
#import "MantleAPI.h"
@implementation CoreDataAPI

+(NSManagedObjectContext *)grabGlobalManagedObjectContext{
    CoreDataAssembly *assembly = [CoreDataAssembly sharedManager];
    NSManagedObjectContext *context = assembly.managedObjectContext;
    return context;
}

+(NSManagedObjectModel *)grabGlobalyManagedObjectModel{
    CoreDataAssembly *assembly = [CoreDataAssembly sharedManager];
    NSManagedObjectModel *model = assembly.managedObjectModel;
    return model;
}
+(NSPersistentStoreCoordinator *)grabGloballyPersistentStoreCoordinator{
    CoreDataAssembly *assembly = [CoreDataAssembly sharedManager];
    NSPersistentStoreCoordinator *PSC = assembly.persistentStoreCoordinator;
    return PSC;
}

#pragma mark - update and insert
+(void)updateCoreDataStoreWithPostArray{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
    NSManagedObjectContext *context = [self grabGlobalManagedObjectContext];
    NSMutableArray *coffeeList = [MantleAPI grabGlobalCoffeeList];
    for (CoffeePost *coffeePost in coffeeList) {
        
        NSArray *result = [self fetchSpecificCoffeePost:coffeePost.name];
        if ([result count]>0) {
            //updates outdated posts with new information. Basing this off of the "Updated 2 weeks ago" in the detail view controller
            NSLog(@"updating Post");
            Post *post = [result objectAtIndex:0];
            post.name = coffeePost.name;
            post.desc = coffeePost.desc;
            if (![coffeePost.imageurl isEqualToString:@""]) {
                post.hasImage = [NSNumber numberWithBool:YES];
                post.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:coffeePost.imageurl]];
                
            }
            
            NSError *error = nil;
            [context save:&error];
            if (error) {
                NSLog(@"failure to save");

                NSLog(@"%@ %@",error,error.localizedDescription);
            }else{
                NSLog(@"successful update");
            }
        }
        else{
            //insert new value if one isn't found
            NSLog(@"insert new value");
            NSEntityDescription*entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:context];

            Post *post = [[Post alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
            post.name = coffeePost.name;
            post.desc = coffeePost.desc;
            if (![coffeePost.imageurl isEqualToString:@""]) {
                post.hasImage = [NSNumber numberWithBool:YES];
                post.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:coffeePost.imageurl]];
            }
            [self attemptToInsertPost:post];
            
        }
    }
    });

}
+(BOOL)attemptToInsertPost:(Post *)post{
    NSManagedObjectContext *context = [self grabGlobalManagedObjectContext];
    NSLog(@"attempt to insert new object");
    NSArray *result = [self fetchSpecificCoffeePost:post.name];
    NSError *error = nil;
    [context save:&error];
    
    NSLog(@"%@",[result objectAtIndex:0]);
    if ([result count]==0) {
        //Create an insert version of the post for clarity
        NSEntityDescription*entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:context];
        Post *insertPost = [[Post alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
        insertPost.name = post.name;
        insertPost.desc = post.desc;
        if (post.hasImage) {
            insertPost.hasImage = [NSNumber numberWithBool:YES];
            insertPost.imageData = post.imageData;
        }

        NSError *error = nil;
        [context save:&error];
        if (error) {
            NSLog(@"%@,%@",error,error.localizedDescription);
            return false;
        }else{
            NSLog(@"successful new object inserted");
            return true;
        }
    }
    return false;
}

#pragma mark - fetch
+(NSArray *)fetchSpecificCoffeePost:(NSString *)name{
    
    NSManagedObjectContext *context = [self grabGlobalManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:context];
    
    //Indexed the name property with a B-tree to ensure efficient search
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K==%@",@"name",name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObject = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"%@,%@",error,error.localizedDescription);
    }else{
        NSLog(@"successful fetch of specific post");
    }
    return fetchedObject;
}

+(NSArray *)fetchStoredCoffeeArray{
    
    NSManagedObjectContext *context = [self grabGlobalManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    if (error) {
        NSLog(@"%@,%@",error,error.localizedDescription);
    }else{
        NSLog(@"successful fetch of coffee list");
    }

    return fetchedObjects;
}
#pragma mark -maintain

+(void)preventCacheFromGettingTooLarge{
    
    NSArray *array = [self fetchStoredCoffeeArray];
    if ([array count]>15) {
        //I would add this method in if there was some time stamp associated with the different posts. I would fetch all of the results using a sort descriptor in ascending time, then I would delete all of the posts except the last 15. This method would run whenever the app was preparing to enter the foreground to ensure smooth performance
        
    }
}
@end
