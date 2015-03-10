//
//  CoffeePost.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
@interface CoffeePost : MTLModel <MTLJSONSerializing>

@property(strong,nonatomic)NSString *desc;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *imageurl;
@property(strong,nonatomic)NSString *identifier;
@property(strong,nonatomic)NSData *imageData;
@end
