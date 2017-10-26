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
  
    self.tableView.backgroundColor = [StyleKitName gradientColor8];
    
   }



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
     
        self.meetingObject = [[MeetingObject alloc] init];
        
        
        self.meetingObject.personName = self.personNameTextField.text;
        self.meetingObject.phoneNumber = self.personPhoneTextField.text;
        
        NSDate *myDate = _datePicker.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        //[dateFormat setDateFormat:@"hh:mm a"];
        [dateFormat setDateFormat:@"HH:mm"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];
        [dateFormat setLocale:locale];
        NSString *timeString = [dateFormat stringFromDate:myDate];
    
        NSDate *myDate2 = _datePicker.date;
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"MMM d,ccc"];
        NSLocale *locale2 = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];
        [dateFormat2 setLocale:locale];;
        NSString *timeString2 = [dateFormat2 stringFromDate:myDate2];
        
        
        self.meetingObject.time = timeString;
        self.meetingObject.date = timeString2;
        
    }
 }


// unwind segue from SelectMeetingVC
- (IBAction)unwindFromSelectMeetingVC:(UIStoryboardSegue*)segue {
    
}



- (IBAction)datePickerValueChanged:(id)sender {

 NSDate *selectedDate = [sender date];



}
@end
