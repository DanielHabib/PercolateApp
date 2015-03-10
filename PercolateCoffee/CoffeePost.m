//
//  CoffeePost.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "CoffeePost.h"

@implementation CoffeePost




+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageurl" : @"image_url",
             @"identifier" : @"id"
             };
}
@end
