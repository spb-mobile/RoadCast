//
//  MessagesViewController.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@class MessageStore;
@class Message;

@interface MessagesViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) MessageStore *messageStore;

- (void)addMessage:(Message *)message;

@end
