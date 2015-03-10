//
//  DetailViewController+Constraints.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/9/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "DetailViewController+Constraints.h"

@implementation DetailViewController (Constraints)




+(void)setUpConstraintsWithViews:(NSDictionary *)views andViewController:(DetailViewController*)myVC{

    [myVC.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-0.0-[_tableView]-0.0-|" options:0 metrics:nil views:views]];
    [myVC.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-0.0-[navBar(50)]-0.0-[_tableView]-0.0-|" options:0 metrics:nil views:views]];
    [myVC.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0.0-[navBar]-0.0-|" options:0 metrics:nil views:views]];
    [myVC.tableView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]|" options:0 metrics:nil views:views]];
    
    [myVC.tableView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[headerView(_tableView)]|" options:0 metrics:nil views:views]];

    [myVC.tableView.tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10.0-[titleLabel]-|" options:0 metrics:nil views:views]];
    [myVC.tableView.tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10.0-[titleLabel]-[separatorView(1.0)]|" options:0 metrics:nil views:views]];
    
        [myVC.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20.0-[separatorView]|" options:0 metrics:nil views:views]];
}

@end
