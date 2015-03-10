//
//  UtilityFunctions.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface UtilityFunctions : NSObject

+(UIImage *)resizeImage:(UIImage *)image
             imageSize:(CGSize)size;

+(UIImage *)GenerateWhiteImage:(UIImage *)image;

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(UIColor *)grabPercolateOrange;
+(UIColor *)grabPercolateGray;
+(UIColor *)grabPercolateDarkGray;
@end
