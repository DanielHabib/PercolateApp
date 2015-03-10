//
//  UtilityFunctions.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "UtilityFunctions.h"


@implementation UtilityFunctions

#pragma mark - Image Manipulation
+ (UIImage *)GenerateWhiteImage:(UIImage *)image
{
    CGRect r;
    CGSize size = image.size;
    r.origin.x = r.origin.y = 0;
    r.size = size;
    
    UIGraphicsBeginImageContextWithOptions(r.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context,  kCGInterpolationHigh);
    
    CGContextClipToMask(context, r, [image CGImage]);
    
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *whiteImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    // Image was being flipped so I added the following manipulation to flip it back to normal.
    whiteImage = [UIImage imageWithCGImage:whiteImage.CGImage
                                                scale:whiteImage.scale
                                          orientation:UIImageOrientationDownMirrored];
    return whiteImage;
}

+(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

#pragma mark - Color 
+(UIColor *)colorWithHexString:(NSString *)hexString{
    unsigned int hex;
    [[NSScanner scannerWithString:hexString] scanHexInt:&hex];
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}



+(UIColor *)grabPercolateOrange{
    
    return [self colorWithHexString:@"F16421"];
}
+(UIColor *)grabPercolateGray{
    return [self colorWithHexString:@"AAAAAA"];

}
+(UIColor *)grabPercolateDarkGray{
    return [self colorWithHexString:@"666666"];
}
@end
