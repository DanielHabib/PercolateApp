//
//  AFNetworkingAssembly.m
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import "AFNetworkingAssembly.h"

@implementation AFNetworkingAssembly
+ (id)sharedManager {
    static AFNetworkingAssembly *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.baseURL = [NSURL URLWithString: @"http://coffeeapi.percolate.com/"];
        self.apiKey = @"WuVbkuUsCXHPx3hsQzus4SE";
    }
    return self;
}


@end
