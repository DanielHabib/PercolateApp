//
//  AppDelegate.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NAV_BAR_HEIGHT 44

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) NSManagedObjectContext *ManagedObjectContext;

@end

