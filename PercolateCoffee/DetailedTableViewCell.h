//
//  DetailedTableViewCell.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/8/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePost.h"
#import "DetailViewController.h"

@interface DetailedTableViewCell : UITableViewCell
@property UILabel *title;
@property UITextView *desc;
@property UIImageView *coffeeImageView;
-(void)configureCellWithIndex:(NSInteger)index coffeePost:(CoffeePost *)coffeePost intoVC:(DetailViewController*)myVC;

@end
