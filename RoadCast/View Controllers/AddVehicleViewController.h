//
//  AddVehicleViewController.h
//  RoadCast
//
//  Created by Vitaly Dyachkov on 05.03.15.
//  Copyright (c) 2015 FirstLineSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Vehicle;

@interface AddVehicleViewController : UITableViewController

@property (nonatomic, strong) Vehicle *vehicle;

@property (nonatomic, getter=isEditable) BOOL editable;

@end
