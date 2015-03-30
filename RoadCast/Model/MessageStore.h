//
//  MessageStore.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 22/03/15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;

@interface MessageStore : NSObject

- (NSArray *)allMessages;
- (void)addMessage:(Message *)message;

@end
