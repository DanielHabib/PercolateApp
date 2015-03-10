//
//  DetailViewController.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "DetailViewController.h"
#import "UtilityFunctions.h"
#import "PercolateNavBar.h"
#import "MainTableViewController.h"
#import "APICollection.h"
#import "DetailedTableViewCell.h"
#import "UIView+autoLayout.h"
#import "DetailViewController+Constraints.h"

@implementation DetailViewController{
    PercolateNavBar *navBar;
    NSMutableArray *detailedArray;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    navBar = [PercolateNavBar buildStandardNavBar];
    
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor clearColor];

    UINavigationItem *navBarLogo = [PercolateNavBar grabNavBarLogoItem];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"SHARE" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.userInteractionEnabled = YES;
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    button.frame=CGRectMake(0.0, 100.0, 60.0, 30.0);
    [button addTarget:self action:@selector(shareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* shareItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    navBarLogo.rightBarButtonItem = shareItem;
    navBarLogo.leftBarButtonItem = backButton;

    navBar.items=@[navBarLogo];
    navBar.translatesAutoresizingMaskIntoConstraints=NO;
    //navBar = [PercolateNavBar buildStandardNavBar];
    navBar.userInteractionEnabled=YES;
    
    UIView *headerView = [UIView autolayoutView];
    UILabel *titleLabel = [UILabel autolayoutView];
    
    titleLabel.text = self.coffeePost.name;
    titleLabel.font = [UIFont fontWithName:@"Times" size:30];
    titleLabel.textColor = [UtilityFunctions grabPercolateDarkGray];
    
    self.tableView = [UITableView autolayoutView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.tableHeaderView = headerView;
    UIView *separatorView = [UIView autolayoutView];
    separatorView.backgroundColor = [UtilityFunctions grabPercolateGray];
    
    [_tableView.tableHeaderView addSubview:separatorView];
    [_tableView.tableHeaderView addSubview:titleLabel];
    
    [titleLabel sizeToFit];
    [navBar setTranslucent:NO];
    [self.view addSubview:navBar];
    [self.view addSubview:self.tableView];
    self.tableView.separatorColor = [UIColor clearColor];

    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel,_tableView,headerView,navBar,separatorView);
    [DetailViewController setUpConstraintsWithViews:views andViewController:self];
}

#pragma mark - Nav Bar Methods

-(void)backButtonPressed{
    MainTableViewController *mainVC= [[MainTableViewController alloc] init];
    [self presentViewController:mainVC animated:NO completion:nil];
}
-(void)shareButtonPressed{
    NSLog(@"Shared");
}

#pragma mark - tableview datasource


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    DetailedTableViewCell *cell = (DetailedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DetailedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configureCellWithIndex:indexPath.row  coffeePost:self.coffeePost intoVC:self];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    DetailedTableViewCell *cell = (DetailedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DetailedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell configureCellWithIndex:indexPath.row  coffeePost:self.coffeePost intoVC:self];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return _tableView.tableHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}


@end
