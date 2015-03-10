//
//  StartupViewController.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "MainTableViewController.h"
#import "PercolateNavBar.h"
#import "UtilityFunctions.h"
#import "DetailViewController.h"
#import "CoffeeTableViewCell.h"
#import "UIView+autoLayout.h"

#import "APICollection.h"

@interface MainTableViewController ()
@property NSMutableArray *coffeeList;
@property NSMutableArray *globalCoffeeList;


@end

@implementation MainTableViewController{
    PercolateNavBar *navBar;
    NSMutableDictionary *heightCache;
    BOOL heightCacheComplete;
}


#pragma mark - View Controller Delegate
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [CoreDataAPI updateCoreDataStoreWithPostArray];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [AFNetworkingAPI FetchFullListFromServerIntoVC:self];
    _coreDataFlag = false;
    _coreDataArray = [CoreDataAPI fetchStoredCoffeeArray];
    if ([_coreDataArray count]>0) {
        _coreDataFlag=true;
    }
    
    heightCacheComplete = false;
    heightCache = [[NSMutableDictionary alloc]init];
    _cachedImages = [[NSMutableDictionary alloc]init];
    _cacheComplete = false;
    
    self.coffeeList = [[NSMutableArray alloc]init];
    self.tableView = [UITableView autolayoutView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    navBar = [PercolateNavBar buildStandardNavBar];
    navBar.userInteractionEnabled=YES;
    navBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:navBar];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView,navBar);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-0.0-[_tableView]-0.0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-0.0-[navBar(50)]-0.0-[_tableView]-0.0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0.0-[navBar]-0.0-|" options:0 metrics:nil views:views]];
    

    self.globalCoffeeList = [MantleAPI grabGlobalCoffeeList];


}
-(void)globalListPopulated{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        
    if ([self.globalCoffeeList count]!=0) {
        [self populateCache];
        [self populateHeightCache];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NavBar Delegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}


#pragma mark - Table View Datasource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    if (_cacheComplete) {
        return [[self.globalCoffeeList copy ]count];
    }else if (_coreDataFlag){
        return [[_coreDataArray copy] count];
    }
    
    return [[self.globalCoffeeList copy] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier;
    
    BOOL hasImage = [self chooseReuseIdentifierAtIndex:indexPath.row];
    if (hasImage) {
        cellIdentifier = @"CoffeeCellWithImage";

    }else{
        cellIdentifier = @"CoffeeCell";
    }    
    
    CoffeeTableViewCell *cell = (CoffeeTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CoffeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CoffeePost *coffeePost=[[CoffeePost alloc]init];
    
    if (_cacheComplete) {
        coffeePost = [self.globalCoffeeList objectAtIndex:indexPath.row];
    }else if (_coreDataFlag){
       Post *post   = [_coreDataArray objectAtIndex:indexPath.row];
        coffeePost.name  = post.name;
        coffeePost.desc = post.desc;
        if (post.hasImage) {
            coffeePost.imageurl = @"existingURL";
            coffeePost.imageData = post.imageData;
            
        }
    }
    if (hasImage) {
        cell.hasImage=true;
    }else{
        cell.hasImage=false;
    }
    [cell configureCellWithDataInPost:coffeePost inViewController:self atIndex:indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (heightCacheComplete) {
        CGFloat height =[[[heightCache  copy ]objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] floatValue];
        return height+0.0;
    }
    static NSString *cellIdentifier;
    
    BOOL hasImage = [self chooseReuseIdentifierAtIndex:indexPath.row];
    if (hasImage) {
        cellIdentifier = @"CoffeeCellWithImage";
        
    }else{
        cellIdentifier = @"CoffeeCell";
    }
    
    
    CoffeeTableViewCell *cell = (CoffeeTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CoffeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if (hasImage) {
        cell.hasImage=true;
    }else{
        cell.hasImage=false;
    }
    
    CoffeePost *coffeePost=[[CoffeePost alloc]init];
    if (_cacheComplete) {
        coffeePost = [self.globalCoffeeList objectAtIndex:indexPath.row];
    }
    else if(_coreDataFlag){
        Post *post = [_coreDataArray objectAtIndex:indexPath.row];
        coffeePost.name = post.name;
        coffeePost.desc = post.desc;
        if(post.hasImage){
            coffeePost.imageData = post.imageData;
            coffeePost.imageurl = @"validURL";
        }
        
    }
    [cell configureCellWithDataInPost:coffeePost inViewController:self atIndex:indexPath.row];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        //potential bad access

    return size.height+1.0 ;

}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailVC = [[DetailViewController alloc]init];
    if (_cacheComplete) {
        detailVC.coffeePost = [self.globalCoffeeList objectAtIndex:indexPath.row];
        detailVC.imageData = [_cachedImages objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

    }
    else if (_coreDataFlag){
        Post *post = [_coreDataArray objectAtIndex:indexPath.row];
        detailVC.coffeePost = [[CoffeePost alloc]init];
        detailVC.coffeePost.name =post.name;
        detailVC.coffeePost.desc = post.desc;
        detailVC.coffeePost.imageData = post.imageData;
        detailVC.imageData = post.imageData;
    }
    
    [self presentViewController:detailVC animated:NO completion:nil];
}
-(BOOL)chooseReuseIdentifierAtIndex:(NSInteger)index {
    
    CoffeePost *coffeePost = [[CoffeePost alloc]init];
    if (_cacheComplete) {
        coffeePost = [self.globalCoffeeList objectAtIndex:index];

    }else if (_coreDataFlag){
        Post *post = [_coreDataArray objectAtIndex:index];
        coffeePost.name = post.name;
        coffeePost.desc = post.desc;
        coffeePost.imageData = [NSData dataWithData:post.imageData];
        if (post.hasImage) {
            return true;
            
        }else{
            return false;
            
        }
    }
    
    BOOL hasImage = false;
    if (_cacheComplete) {
        if ([_cachedImages objectForKey:[NSString stringWithFormat:@"%ld",(long)index]]) {
            hasImage = true;
        }
        else if(_coreDataFlag){
            if (![coffeePost.imageurl isEqualToString:@""]) {
                hasImage=true;
            }
            else{
                hasImage=false;
            }
        }else{
            hasImage = false;
        }
    }else{
        if (![coffeePost.imageurl isEqualToString:@""]) {
            hasImage = true;
        }
        else{
            hasImage = false;
        }
    }
    if (hasImage) {
        return true;
        
    }else{
        return false;
    }
}


#pragma mark - cache
-(void)populateHeightCache{
    if ([self.globalCoffeeList count]>0) {

    if (!heightCacheComplete) {
        
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
    static NSString *cellIdentifier;
    
    for (CoffeePost *coffeePost in [self.globalCoffeeList copy]) {
        
        NSInteger index = [self.globalCoffeeList indexOfObject:coffeePost];
    BOOL hasImage = [self chooseReuseIdentifierAtIndex:index];
    if (hasImage) {
        cellIdentifier = @"CoffeeCellWithImage";
        
    }else{
        cellIdentifier = @"CoffeeCell";
    }
    
    
    CoffeeTableViewCell *cell = (CoffeeTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CoffeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (hasImage) {
        cell.hasImage=true;
    }else{
        cell.hasImage=false;
    }
   
        CoffeePost *coffeePost = [self.globalCoffeeList objectAtIndex:index];
        [cell configureCellWithDataInPost:coffeePost inViewController:self atIndex:index];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [heightCache setObject:[NSNumber numberWithFloat:size.height+1] forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    }
        heightCacheComplete = true;
    });
    }
    }

}

-(void)populateCache{
    if ([self.globalCoffeeList count]>0) {
        
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        for (CoffeePost *post in [self.globalCoffeeList copy]) {
            if (![post.imageurl isEqualToString:@""]) {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: post.imageurl]];
                if (imageData) {
                    [_cachedImages setValue:imageData forKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self.globalCoffeeList indexOfObject:post]]];
                }
            }
        }
        NSLog(@"cache Complete!");
        _cacheComplete = true;
        //[self.tableView reloadData];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        NSLog(@"length %lu",(unsigned long)[_cachedImages count]
              );
    });
        }
}

@end
