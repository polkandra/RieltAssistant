//
//  SelectMeetingOblectVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMeetingController.h"
#import "CoreDataTableVC.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "SelectMeetingCell.h"
#import "EstateObject.h"
#import "StyleKitName.h"
#import "NewMeetingDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SelectMeetingOblectVC : CoreDataTableVC <UITableViewDataSource, UITableViewDataSource>

@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)configureCell:(SelectMeetingCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
