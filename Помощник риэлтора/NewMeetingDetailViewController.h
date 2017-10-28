//
//  NewMeetingsDetailViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 27.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingObject.h"
#import "MeetingsViewController.h"
#import "StyleKitName.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "EstateObject.h"
#import "DataManager.h"
#import "DetailMeetingController.h"

@interface NewMeetingDetailViewController : UITableViewController 

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *personPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *meetDetailsTextView;

@property (strong, nonatomic) EstateObjectEntity* detailItem;
@property(strong, nonatomic) MeetingObject *meetingObject;

@property (weak, nonatomic) IBOutlet UILabel *chooseObjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;


- (IBAction)datePickerValueChanged:(id)sender;


@end
