//
//  MessageStore.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 22/03/15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "MessageStore.h"

@interface MessageStore ()

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation MessageStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _messages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allMessages {
    return [self.messages copy];
}

- (void)addMessage:(Message *)message {
    [self.messages addObject:message];
}

@end
