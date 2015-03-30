//
//  MyVehiclesViewController.m
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import "MyVehiclesViewController.h"
#import "AddVehicleViewController.h"

#import "User.h"
#import "Vehicle.h"

@interface MyVehiclesViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *myVehicles;

@property (nonatomic, weak) AddVehicleViewController *addVehicleViewController;

@end

@implementation MyVehiclesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myVehicles = [self.user.myVehicles mutableCopy];
}

#pragma mark - Actions

- (void)finishAddingVehicle {
    [self.addVehicleViewController.vehicle removeObserver:self forKeyPath:@"plateNumber.length" context:NULL];
    
    [self.addVehicleViewController dismissViewControllerAnimated:YES completion:^{
        Vehicle *vehicle = self.addVehicleViewController.vehicle;
        [self.user addVehicle:vehicle];
        [self.myVehicles addObject:vehicle];
        
        [self.tableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.myVehicles count] - 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }];
}

- (void)cancelAddingVehicle {
    [self.addVehicleViewController.vehicle removeObserver:self forKeyPath:@"plateNumber.length" context:NULL];
    
    [self.addVehicleViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIBarButtonItem *doneBarButtonItem = self.addVehicleViewController.navigationItem.rightBarButtonItem;
    doneBarButtonItem.enabled = [change[@"new"] unsignedIntegerValue] > 0;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myVehicles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VehicleCell"
                                                            forIndexPath:indexPath];
    
    Vehicle *vehicle = self.myVehicles[indexPath.row];
    cell.textLabel.text = vehicle.plateNumber;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddVehicle"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        self.addVehicleViewController = (AddVehicleViewController *)navigationController.topViewController;
        
        Vehicle *vehicle = [[Vehicle alloc] init];
        
        [vehicle addObserver:self forKeyPath:@"plateNumber.length" options:NSKeyValueObservingOptionNew context:NULL];
        
        self.addVehicleViewController.vehicle = vehicle;
        self.addVehicleViewController.editable = YES;
        
        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(finishAddingVehicle)];
        doneBarButtonItem.enabled = NO;
        self.addVehicleViewController.navigationItem.rightBarButtonItem = doneBarButtonItem;
        
        UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(cancelAddingVehicle)];
        self.addVehicleViewController.navigationItem.leftBarButtonItem = cancelBarButtonItem;
    }
    
    if ([segue.identifier isEqualToString:@"ViewVehicle"]) {
        AddVehicleViewController *addVehicleViewController = segue.destinationViewController;
        
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        addVehicleViewController.vehicle = self.myVehicles[indexPath.row];
    }
}

@end
