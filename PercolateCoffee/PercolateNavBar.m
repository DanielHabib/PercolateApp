//
//  PercolateNavBar.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "PercolateNavBar.h"
#import "AppDelegate.h"
#import "UtilityFunctions.h"
@implementation PercolateNavBar



+(PercolateNavBar *)buildStandardNavBar{
    PercolateNavBar *navBar = [[PercolateNavBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen ]bounds].size.width, NAV_BAR_HEIGHT)];

    UINavigationItem *PercLogoNavItem = [self grabNavBarLogoItem];
    navBar.items = @[PercLogoNavItem];
    navBar.barTintColor = [UtilityFunctions grabPercolateOrange];
    
    return navBar;
}


+(UINavigationItem *)grabNavBarLogoItem{
    
    
    UIImageView *perLogoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, NAV_BAR_HEIGHT-10, NAV_BAR_HEIGHT-10)];
    
    perLogoIV.image = [UtilityFunctions GenerateWhiteImage: [UtilityFunctions resizeImage:[UIImage imageNamed:@"drip.png"] imageSize:perLogoIV.frame.size]] ;
    perLogoIV.contentMode = UIViewContentModeScaleAspectFill;
    perLogoIV.clipsToBounds = YES;
    UINavigationItem *PercLogoNavItem = [[UINavigationItem alloc]init];
    PercLogoNavItem.titleView = perLogoIV;
    return PercLogoNavItem;
    
}

+(UIBarButtonItem *)grabShareButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"SHARE" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.userInteractionEnabled = YES;
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
    
    UIBarButtonItem* shareItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return shareItem;
}
@end
