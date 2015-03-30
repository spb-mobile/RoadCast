//
//  NewMessageViewController.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "NewMessageViewController.h"
#import "AddVehicleViewController.h"
#import "MessagesViewController.h"

#import "Message.h"
#import "Vehicle.h"

@interface NewMessageViewController () <UITextViewDelegate>

@property (nonatomic, strong) Message *message;

@property (nonatomic, weak) IBOutlet UITextView *messageTextView;
@property (nonatomic, weak) IBOutlet UILabel *plateNumberLabel;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *sendBarButtonItem;

@property (nonatomic, weak) IBOutlet UITableViewCell *plateNumberCell;

@end

@implementation NewMessageViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.message = [[Message alloc] init];
    self.message.vehicle = [[Vehicle alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.plateNumberLabel.text = self.message.vehicle.plateNumber;
    
    // iOS 8 bug workaround
    [self.plateNumberCell layoutSubviews];
    
    [self enableDoneIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.messageTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.messageTextView resignFirstResponder];
}

#pragma mark - UI

- (void)enableDoneIfNeeded {
    self.sendBarButtonItem.enabled = ([self.message.text length] > 0 && [self.message.vehicle.plateNumber length] > 0);
}

#pragma mark - Actions

- (IBAction)send:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.messagesViewController addMessage:self.message];
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView == self.messageTextView) {
        self.message.text = self.messageTextView.text;
        
        [self enableDoneIfNeeded];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SetVehicle"]) {
        AddVehicleViewController *addVehicleViewController = (AddVehicleViewController *)segue.destinationViewController;
        
        addVehicleViewController.vehicle = self.message.vehicle;
        addVehicleViewController.editable = YES;
    }
}

@end
