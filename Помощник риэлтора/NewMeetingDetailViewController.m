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
@synthesize tableView, detailItem;



#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.backgroundColor = [StyleKitName gradientColor8];
    
    [self hideLabels];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
     
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
        NSString *dateAndTime = [timeString stringByAppendingString:timeString2];
        
        MeetingObjectEntity* object =
        [NSEntityDescription insertNewObjectForEntityForName:@"MeetingObjectEntity"
                                      inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
        
        MeetingsViewController *mVC = (MeetingsViewController *)segue.destinationViewController;
        //DetailMeetingController *dmVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailMeeting"];
        //dmVC.detailItem = self.detailItem;
        mVC.detailItem = self.detailItem;
        
        object.time = timeString;
        object.date = timeString2;
        object.objectName = self.nameLabel.text;
        object.personName = self.personNameTextField.text;
        object.dateAndTime = dateAndTime;
        object.phoneNumber = self.personPhoneTextField.text;
        object.meetDetails = self.meetDetailsTextView.text;
        
        if (self.meetDetailsTextView.text.length > 0) {
        
        object.meetDetails = self.meetDetailsTextView.text;
        
        }else{
            
            object.meetDetails = @"Нет заметок по встрече";
            
        }
        
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
    }
 }


// unwind segue from SelectMeetingVC
- (IBAction)unwindFromSelectMeetingVC:(UIStoryboardSegue*)segue {
   
    [self updateUI];

}

#pragma mark - Helpers


-(void)updateUI {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"address"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"price"]];
    self.pictureImageView.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
}


-(void)hideLabels {
    
    self.nameLabel.hidden = YES;
    self.addressLabel.hidden = YES;
    self.priceLabel.hidden = YES;
}

#pragma mark - Actions

- (IBAction)datePickerValueChanged:(id)sender {

 NSDate *selectedDate = [sender date];

}
@end
