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

@interface NewMeetingDetailViewController : UITableViewController 

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *personPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *meetDetailsTextView;


@property(strong, nonatomic) MeetingObject *meetingObject;



- (IBAction)datePickerValueChanged:(id)sender;


@end
