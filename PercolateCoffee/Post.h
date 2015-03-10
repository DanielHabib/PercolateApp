//
//  Post.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/9/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Post : NSManagedObject

@property (nonatomic, retain) NSNumber * hasImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSData * imageData;

@end
