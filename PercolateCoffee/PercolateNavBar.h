//
//  PercolateNavBar.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercolateNavBar : UINavigationBar
+(PercolateNavBar *)buildStandardNavBar;
+(UIBarButtonItem *)grabShareButton;
+(UINavigationItem *)grabNavBarLogoItem;
@end
