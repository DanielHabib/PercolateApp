//
//  CoffeeTableViewCell.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "CoffeeTableViewCell.h"
#import "UIView+autoLayout.h"
#import "Post.h"
#import "UtilityFunctions.h"
@implementation CoffeeTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;

        CoffeeTableViewCell *cell = self;
        _hasImage = false;
        _name = [UILabel autolayoutView];
        _desc = [UILabel autolayoutView];
        _accessoryIndicator = [UILabel autolayoutView];
        _coffeeImage = [UIImageView autolayoutView];
        
        [self assignPropertiesToLabels];
        
        [cell.contentView addSubview:_name];
        [cell.contentView addSubview:_desc];
        [cell.contentView addSubview:_accessoryIndicator];
        [cell.contentView addSubview:_coffeeImage];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}


-(void)assignPropertiesToLabels{
    
    NSNumber *labelWidth =  [NSNumber numberWithFloat:(self.frame.size.width - 40)];

    _name.numberOfLines=1;
    _name.backgroundColor = [UIColor clearColor];
    _name.font = [UIFont fontWithName:@"Times" size:15];
    _name.textColor = [UtilityFunctions grabPercolateDarkGray];
    [_name setPreferredMaxLayoutWidth: [labelWidth floatValue]];
    
    _desc.font = [UIFont fontWithName:@"Times" size:14];
    _desc.textColor = [UtilityFunctions grabPercolateGray];
    _desc.numberOfLines=2;
    _desc.backgroundColor = [UIColor clearColor];
    [_desc setPreferredMaxLayoutWidth:[labelWidth floatValue]];
    
    

    _desc.lineBreakMode = NSLineBreakByWordWrapping;
    _accessoryIndicator.backgroundColor = [UIColor clearColor];
    _accessoryIndicator.textColor = [UtilityFunctions grabPercolateGray];

    _coffeeImage.contentMode = UIViewContentModeScaleAspectFit;
    _coffeeImage.backgroundColor = [UIColor clearColor];    

}



-(void)configureCellWithDataInPost:(CoffeePost *)coffeePost inViewController:(MainTableViewController*)myView atIndex:(NSInteger)index{
    CoffeeTableViewCell *cell = self;
    _accessoryIndicator.text = @">";
    _name.text = coffeePost.name;
    _desc.text = coffeePost.desc;
    NSNumber *labelWidth =  [NSNumber numberWithFloat:(self.frame.size.width - 40)];
    if(!_hasImage){
        NSDictionary *metrics = @{@"accesoryWidth":@50.0,@"labelSpacing":@5.0,@"required":@(UILayoutPriorityRequired),@"labelWidth":labelWidth,@"lowPriority":@(UILayoutPriorityDefaultLow),@"accessorySpacing":@50.0};
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_name,_desc,_accessoryIndicator);
        
        [cell.contentView addConstraints:[self generateConstraintsWithoutImageWithMetrics:metrics views:views]];

    }else{
        
        //Bad Access here?
        UIImage *image =[UIImage imageNamed:@"imageHolderDrip.png"];
        _coffeeImage.image = image;
        if (myView.cacheComplete) {
            id imageData = [myView.cachedImages objectForKey:[NSString stringWithFormat:@"%ld",index]];
                _coffeeImage.image= [UIImage imageWithData:imageData];
        }else if (myView.coreDataFlag){
            Post *post = [myView.coreDataArray objectAtIndex:index];
            id imageData = post.imageData;
            _coffeeImage.image = [UIImage imageWithData:imageData];
        }
        else{

//                dispatch_async(queue, ^{
//                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:coffeePost.imageurl]];
//                    dispatch_sync(dispatch_get_main_queue(), ^{
//                       if (imageData) {
//                           UIImage *image =[UIImage imageWithData:imageData];
//                           _coffeeImage.image = image;
//                       }
//                    });
//                });
        }
    
        
        NSArray *imageDimensions = [CoffeeTableViewCell validateImageSizeWithHeight:_coffeeImage.image.size.height Width:_coffeeImage.image.size.width];
        NSNumber *imageHeight = [imageDimensions objectAtIndex:0];
        NSNumber *imageWidth = [imageDimensions objectAtIndex:1];
        
        
        
        NSDictionary *metrics = @{@"accesoryWidth":@50.0,@"labelSpacing":@5.0,@"required":@(UILayoutPriorityRequired),@"labelWidth":labelWidth,@"lowPriority":@(UILayoutPriorityDefaultLow),@"accessorySpacing":@50.0,@"imageWidth":imageWidth,@"imageHeight":imageHeight};
   
        NSDictionary *views = NSDictionaryOfVariableBindings(_name,_desc,_accessoryIndicator,_coffeeImage);
        
        [cell.contentView addConstraints:[self generateConstraintsWithValidImageUsingMetrics:metrics views:views]];

        
        
    }
    [cell.contentView layoutSubviews];

}
-(NSArray *)generateConstraintsWithoutImageWithMetrics:(NSDictionary *)metrics views:(NSDictionary *)views{
    NSMutableArray *arrayHolder = [[NSMutableArray alloc ]init];
    
    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_name]-0.0-[_desc]-|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_accessoryIndicator(10)]" options:0 metrics:metrics views:views]];
    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_desc]-accessorySpacing-[_accessoryIndicator(10)]-|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];

    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_name]" options:0 metrics:metrics views:views]];

    return arrayHolder;
    
}




-(NSArray *)generateConstraintsWithValidImageUsingMetrics:(NSDictionary *)metrics views:(NSDictionary*)views{
    NSMutableArray *arrayHolder =[[NSMutableArray alloc]init];
    [ arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_name(20)]-0.0-[_desc]-8.0@required-[_coffeeImage(<=250)]-|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];
    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_coffeeImage(<=250)]" options:0 metrics:metrics views:views]];
    [arrayHolder addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_desc]-accessorySpacing-[_accessoryIndicator(10)]-|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
    return arrayHolder;
}


+(NSArray *)validateImageSizeWithHeight:(CGFloat)Height Width:(CGFloat)Width{
    
    //Recursion in order to maintain aspect ratio
    if (Height>250.0) {
        
        Height = Height*.9;
        Width = Width*.9;
        return [self validateImageSizeWithHeight:Height Width:Width];
        
    }else{
        if (Width>250.0) {
            Height = Height*.9;
            Width = Width*.9;
            return [self validateImageSizeWithHeight:Height Width:Width];
            
        }
    }
    
    return @[[NSNumber numberWithFloat:Height],[NSNumber numberWithFloat:Width]];
    
    
    
}
@end
