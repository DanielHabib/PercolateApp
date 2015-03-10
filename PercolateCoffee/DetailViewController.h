//
//  DetailViewController.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//


#import "AppDelegate.h"
#import "APICollection.h"
@interface DetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property NSData *imageData;

@property(strong,nonatomic) CoffeePost *coffeePost;
@property(strong,nonatomic) UITableView *tableView;

@end
