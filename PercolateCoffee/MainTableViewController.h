//
//  StartupViewController.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//



#import "AppDelegate.h"

@interface MainTableViewController :UIViewController <UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate>
@property NSMutableDictionary *cachedImages;
@property BOOL cacheComplete;
@property(nonatomic,strong)UITableView *tableView;
@property BOOL coreDataFlag;
@property NSArray *coreDataArray;
-(void)globalListPopulated;
@end
