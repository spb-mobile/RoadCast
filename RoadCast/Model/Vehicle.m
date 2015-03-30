//
//  Vehicle.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

- (instancetype)initWithPlateNumber:(NSString *)plateNumber {
    self = [super init];
    if (self) {
        _plateNumber = plateNumber;
    }
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else {
        if ([other isKindOfClass:[self class]]) {
            Vehicle *otherVehicle = (Vehicle *)other;
            return [self.plateNumber isEqualToString:otherVehicle.plateNumber];
        }
    }
    
    return NO;
}

@end
