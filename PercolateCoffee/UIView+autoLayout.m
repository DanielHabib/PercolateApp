//
//  UIView+autoLayout.m
//  
//
//  Created by Daniel Habib on 3/7/15.
//
//

#import "UIView+autoLayout.h"


@implementation UIView (AutoLayout)

+(id)autolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}
@end
