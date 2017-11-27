//
//  DetailMeetingController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 05.07.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingObject.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "EstateObject.h"
#import "MeetingObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "MeetingsViewController.h"
#import "DetailObjectController.h"

@interface DetailMeetingController : UITableViewController

@property(strong, nonatomic) MeetingObjectEntity* myMeetingObject;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EstateObjectEntity* detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailNameOfObject;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeOfMeeting;
@property (weak, nonatomic) IBOutlet UILabel *nameOfOwner;
@property (weak, nonatomic) IBOutlet UILabel *phoneOfOwner;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@property(strong, nonatomic) NSMutableArray *retrievedArray;

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)callButtonTapped:(UIButton *)sender;

@end
