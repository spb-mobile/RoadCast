//
//  Message.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vehicle;

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) Vehicle *vehicle;

@end
