//
//  SecondViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "MeetingsCell.h"
#import "MeetingObject.h"
#import "StyleKitName.h"
#import "NewMeetingDetailViewController.h"
#import "DetailMeetingController.h"
#import "CoreDataTableVC.h"
#import "MeetingObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "MeetingsCell.h"


@interface MeetingsViewController : CoreDataTableVC <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSMutableArray* myMeetingsDetailsData;

@property (weak, nonatomic) IBOutlet UILabel *disclaimerLabel;
@property(strong, nonatomic) NSMutableArray *retrievedArray;

@property(strong, nonatomic) MeetingObjectEntity* meetingObject;
@property(strong, nonatomic) EstateObjectEntity* detailItem;

- (void)configureCell:(MeetingsCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end

