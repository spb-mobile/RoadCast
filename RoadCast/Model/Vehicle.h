//
//  Vehicle.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

- (instancetype)initWithPlateNumber:(NSString *)plateNumber;

@property (nonatomic, copy) NSString *plateNumber;

@end
