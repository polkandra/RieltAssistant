//
//  MeetingsDetailViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 27.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NewMeetingDetailViewController.h"

@interface NewMeetingDetailViewController ()

@end

@implementation NewMeetingDetailViewController
@synthesize tableView;



- (void)viewDidLoad {
    [super viewDidLoad];
  






}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
        
     
        self.meetingObject = [[MeetingObject alloc] init];
        
        //MeetingsViewController *controller = segue.destinationViewController;
        
        self.meetingObject.personName = self.personNameTextField.text;
        self.meetingObject.phoneNumber = self.personPhoneTextField.text;
        
        NSDate *myDate = _datePicker.date;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"hh:mm aa"];
        NSString *timeString = [dateFormat stringFromDate:myDate];
    
        NSDate *myDate2 = _datePicker.date;
        
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"MMM d,ccc"];
        NSString *timeString2 = [dateFormat2 stringFromDate:myDate2];
        
        NSDate *myDate3 = _datePicker.date;
        
        NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
        [dateFormat3 setDateFormat:@"MMM d,ccc,hh:mm aa"];
        NSString *timeString3 = [dateFormat2 stringFromDate:myDate3];
        
            
        self.meetingObject.time = timeString;
        self.meetingObject.date = timeString2;
        self.meetingObject.dateAndTime = timeString3;
        
    }
    
}


- (IBAction)datePickerValueChanged:(id)sender {

 NSDate *selectedDate = [sender date];



}
@end
