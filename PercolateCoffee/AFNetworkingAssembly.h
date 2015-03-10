//
//  AFNetworkingAssembly.h
//  PercolateCoffee
//
//  Created by Daniel Habib on 3/4/15.
//  Copyright (c) 2015 d.g.habib7@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkingAssembly : NSObject


@property (strong,nonatomic)NSURL * baseURL;
@property(strong,nonatomic)NSString *apiKey;
+(id)sharedManager;

@end
