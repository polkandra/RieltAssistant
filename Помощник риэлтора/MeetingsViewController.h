//
//  SecondViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingsCell.h"
#import "MeetingObject.h"
#import "StyleKitName.h"
#import "NewMeetingDetailViewController.h"
#import "DetailMeetingController.h"
#import <EventKit/EventKit.h>

@interface MeetingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSMutableArray* myMeetingsDetailsData;

@property (weak, nonatomic) IBOutlet UILabel *disclaimerLabel;


@property(strong, nonatomic) MeetingObject* meetingObject;






@end

