//
//  CoffeeTableViewCell.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePost.h"
#import "MainTableViewController.h"
@interface CoffeeTableViewCell : UITableViewCell

@property BOOL hasImage;
@property UILabel *name;
@property UILabel *desc;
@property UILabel *accessoryIndicator;
@property UIImageView *coffeeImage;
-(void)configureCellWithDataInPost:(CoffeePost *)coffeePost inViewController:(MainTableViewController*)myView atIndex:(NSInteger)index;
+(NSArray *)validateImageSizeWithHeight:(CGFloat)Height Width:(CGFloat)Width;
@end
