//
//  RoomTypeController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewObjectViewController.h"
#import "MainViewController.h"


@interface RoomTypeController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property(assign, nonatomic) NSInteger selectedRow;
@property(assign, nonatomic) NSInteger selectedRow2;

@property (weak, nonatomic) IBOutlet UITableViewCell *roomCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *houseCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nonLivingCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *earthCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *rentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *flatCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sellCell;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *flatType;
@property (weak, nonatomic) IBOutlet UILabel *roomType;
@property (weak, nonatomic) IBOutlet UILabel *houseType;
@property (weak, nonatomic) IBOutlet UILabel *nonLivingType;
@property (weak, nonatomic) IBOutlet UILabel *earthType;


@property (weak, nonatomic) IBOutlet UILabel *rentType;
@property (weak, nonatomic) IBOutlet UILabel *sellType;

@property (strong, nonatomic) NSMutableArray *myData;
@property (strong, nonatomic)  NSMutableArray *cellSelectedArray;

@end
