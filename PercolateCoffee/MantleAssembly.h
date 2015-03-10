//
//  MantleAssembly.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/5/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "MTLModel.h"
#import "AppDelegate.h"
@interface MantleAssembly : MTLModel

+(id)sharedManager;
@property (strong,nonatomic)NSString *ConditionString;
@property (strong,nonatomic)NSMutableArray *coffeeListArray;
@property (strong,nonatomic)NSMutableDictionary *ConditionDict;
@property (strong,nonatomic)UILabel *conditionLabel;
@end
