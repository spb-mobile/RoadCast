//
//  AddVehicleViewController.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "AddVehicleViewController.h"

#import "Vehicle.h"

@interface AddVehicleViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *plateNumberTextField;

@end

@implementation AddVehicleViewController

#pragma mark - Accessors

- (void)setVehicle:(Vehicle *)vehicle {
    if (_vehicle != vehicle) {
        _vehicle = vehicle;
        
        self.plateNumberTextField.text = vehicle.plateNumber;
    }
}

- (void)setEditable:(BOOL)editable {
    if (_editable != editable) {
        _editable = editable;
        
        self.plateNumberTextField.enabled = editable;
    }
}

#pragma mark - View lifrcycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.vehicle) {
        self.plateNumberTextField.text = self.vehicle.plateNumber;
    }
    
    self.plateNumberTextField.enabled = self.editable;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.plateNumberTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.plateNumberTextField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)plateNumberTextChanged:(UITextField *)sender {
    if (sender == self.plateNumberTextField) {
        self.vehicle.plateNumber = sender.text;
    }
}

@end
