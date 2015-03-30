//
//  NewMessageViewController.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessagesViewController;

@interface NewMessageViewController : UITableViewController

@property (nonatomic, weak) MessagesViewController *messagesViewController;

@end
