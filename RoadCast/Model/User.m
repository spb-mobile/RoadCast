//
//  User.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong) NSMutableArray *privateMyVehicles;

@end

@implementation User

+ (instancetype)currentUser {
    static User *currentUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentUser = [[User alloc] init];
    });
    return currentUser;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.privateMyVehicles = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Accessors

- (NSArray *)myVehicles {
    return [self.privateMyVehicles copy];
}

- (void)addVehicle:(Vehicle *)vehicle {
    [self.privateMyVehicles addObject:vehicle];
}

@end
