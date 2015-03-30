//
//  MessagesViewController.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "MessagesViewController.h"
#import "NewMessageViewController.h"

#import "User.h"
#import "MessageStore.h"
#import "Message.h"
#import "Vehicle.h"

typedef enum : NSUInteger {
    MessagesViewControllerModeTimeline,
    MessagesViewControllerModeInbox,
} MessagesViewControllerMode;

@interface MessagesViewController ()

@property (nonatomic, strong) NSMutableArray *messages; // Used as a local cache

@property (nonatomic, weak) IBOutlet UISegmentedControl *modeSegmentetControl;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *composeBarButtonItem;

@end

@implementation MessagesViewController

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.messages = [[self.messageStore allMessages] mutableCopy];
    
    if (self.modeSegmentetControl.selectedSegmentIndex == MessagesViewControllerModeInbox) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vehicle IN %@", self.user.myVehicles];
        [self.messages filterUsingPredicate:predicate];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)addMessage:(Message *)message {
    [self.messages addObject:message];
    [self.messageStore addMessage:message];
    
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.messages count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (IBAction)switchMode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == MessagesViewControllerModeTimeline) {
        self.navigationItem.rightBarButtonItem = self.composeBarButtonItem;
        
        self.messages = [[self.messageStore allMessages] mutableCopy];
    } else if (sender.selectedSegmentIndex == MessagesViewControllerModeInbox) {
        self.navigationItem.rightBarButtonItem = nil;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vehicle IN %@", self.user.myVehicles];
        [self.messages filterUsingPredicate:predicate];
    }
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    Message *message = self.messages[indexPath.row];
    cell.textLabel.text = message.text;
    cell.detailTextLabel.text = message.vehicle.plateNumber;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                             message:@"You don't need to implement this"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAlertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ComposeMessage"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        NewMessageViewController *newMessageViewController = (NewMessageViewController *)navigationController.topViewController;
        
        newMessageViewController.messagesViewController = self;
    }
}

@end
