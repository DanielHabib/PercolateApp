//
//  MantleAssembly.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/5/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "MantleAssembly.h"
#import "AFNetworkingAPI.h"
@implementation MantleAssembly


+ (id)sharedManager {
    static NSObject *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

        _ConditionString = @"flip";
        _conditionLabel.text = @"flip";
        _coffeeListArray =[[NSMutableArray alloc]init];
        _ConditionDict = [[NSMutableDictionary alloc]init];
        [_ConditionDict setValue:_ConditionString forKey:@"cs"];
        

        
    }
    return self;
}

@end
