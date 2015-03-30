//
//  User.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vehicle;

@interface User : NSObject

+ (instancetype)currentUser;

@property (nonatomic, readonly) NSArray *myVehicles;

- (void)addVehicle:(Vehicle *)vehicle;

@end
