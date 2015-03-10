//
//  DetailedTableViewCell.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/8/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "DetailedTableViewCell.h"
#import "UIView+autoLayout.h"
#import "CoffeeTableViewCell.h"
#import "UtilityFunctions.h"
@implementation DetailedTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
}

-(void)configureCellWithIndex:(NSInteger )index coffeePost:(CoffeePost *)coffeePost intoVC:(DetailViewController*)myVC{
    
    UILabel *detailedLabel = [UILabel autolayoutView];
    detailedLabel.font = [UIFont fontWithName:@"Times" size:15.0];
    detailedLabel.textColor = [UtilityFunctions grabPercolateGray];
    detailedLabel.numberOfLines = 0;
    detailedLabel.lineBreakMode= NSLineBreakByWordWrapping;
    [detailedLabel setPreferredMaxLayoutWidth:200.0];
    [detailedLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [detailedLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    detailedLabel.text = coffeePost.desc;

    UIImageView *imageView = [UIImageView autolayoutView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (myVC.imageData) {
        imageView.image = [UIImage imageWithData:myVC.imageData];
    }
    
    
    UILabel *dateLabel = [UILabel autolayoutView];
    dateLabel.text = @"Updated 1 week ago";
    dateLabel.font = [UIFont fontWithName:@"Georgia-Italic" size:12];
    dateLabel.textColor = [UtilityFunctions grabPercolateGray];
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:detailedLabel];
    [self.contentView addSubview:dateLabel];
    NSDictionary *views = NSDictionaryOfVariableBindings(imageView,detailedLabel,dateLabel);
    NSArray *imageDimensions = [CoffeeTableViewCell validateImageSizeWithHeight:imageView.image.size.height Width:imageView.image.size.width];
    
    NSNumber *imageWidth = [imageDimensions objectAtIndex:1];
    NSNumber *imageHeight = [imageDimensions objectAtIndex:0];
    
    NSDictionary *metrics = @{@"imageWidth":imageWidth,@"imageHeight":imageHeight};
    
    [self addConstraintsWithViews:views andMetrics:metrics];

    [self.contentView layoutSubviews];
}
-(void)addConstraintsWithViews:(NSDictionary *)views andMetrics:(NSDictionary *)metrics{

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[detailedLabel(>=50)]-[imageView(imageHeight@1000)]-[dateLabel]|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20.0-[detailedLabel(<=250)]-10.0-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20.0-[imageView(imageWidth@1000)]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20.0-[dateLabel]|" options:0 metrics:metrics views:views]];
    
}

@end
