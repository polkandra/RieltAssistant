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
@synthesize tableView, detailItem, meetingObject;



#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.backgroundColor = [StyleKitName gradientColor8];
    
 

    
    [self hideShowDeleteSaveButtons];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self updateLabels];
    [self updateUIWithMeetingObject];
    [self updateUIWithDetailItem];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
        
        [self setNotificationwithDate:self.datePicker.date];
        
        NSDate *myDate = _datePicker.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
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
        
        mVC.detailItem = self.detailItem;
        
        object.time = timeString;
        object.date = timeString2;
        object.objectName = self.nameLabel.text;
        object.personName = self.personNameTextField.text;
        object.dateAndTime = dateAndTime;
        object.phoneNumber = self.personPhoneTextField.text;
        object.meetDetails = self.meetDetailsTextView.text;
        object.estateObject = self.detailItem;
        
        if (self.meetDetailsTextView.text.length > 0) {
            
            object.meetDetails = self.meetDetailsTextView.text;
            
        }else{
            
            object.meetDetails = @"Нет заметок по встрече";
            
        }
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        
    }else if ([segue.identifier isEqualToString:@"saveSecondButtonTapedInNewMeetingDetailVC"]) {
        
        DetailMeetingController *dvc = (DetailMeetingController *)segue.destinationViewController;
        dvc.myMeetingObject = self.meetingObject;
        dvc.detailItem = self.detailItem;
        
        if (self.meetingObject) {
            
            NSDate *myDate = _datePicker.date;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
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
            
            
            meetingObject.time = timeString;
            meetingObject.date = timeString2;
            meetingObject.objectName = self.nameLabel.text;
            meetingObject.personName = self.personNameTextField.text;
            meetingObject.dateAndTime = dateAndTime;
            meetingObject.phoneNumber = self.personPhoneTextField.text;
            meetingObject.meetDetails = self.meetDetailsTextView.text;
            meetingObject.estateObject = self.detailItem;
            
            if (self.meetDetailsTextView.text.length > 0) {
                
                meetingObject.meetDetails = self.meetDetailsTextView.text;
                
            }else{
                
                meetingObject.meetDetails = @"Нет заметок по встрече";
                
            }
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
            
        }else{
            
            MeetingObjectEntity* object =
            [NSEntityDescription insertNewObjectForEntityForName:@"MeetingObjectEntity"
                                          inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
            
            MeetingsViewController *mVC = (MeetingsViewController *)segue.destinationViewController;
            mVC.meetingObject = self.meetingObject;
            
            NSDate *myDate = _datePicker.date;
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
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
            
            object.time = timeString;
            object.date = timeString2;
            object.objectName = self.nameLabel.text;
            object.personName = self.personNameTextField.text;
            object.dateAndTime = dateAndTime;
            object.phoneNumber = self.personPhoneTextField.text;
            object.meetDetails = self.meetDetailsTextView.text;
            object.estateObject = self.detailItem;
            
            if (self.meetDetailsTextView.text.length > 0) {
                
                object.meetDetails = self.meetDetailsTextView.text;
                
            }else{
                
                object.meetDetails = @"Нет заметок по встрече";
                
            }
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
        }
        
        
    }else if ([segue.identifier isEqualToString:@"deleteButtonTapedInNewMeetingDetailVC"]) {
        
        
        [[[DataManager sharedManager] managedObjectContext] deleteObject:self.meetingObject];
        
        NSError *error = nil;
        [[[DataManager sharedManager] managedObjectContext] save:&error];
        
    
    
    }
    
}

// unwind segue from SelectMeetingVC
- (IBAction)unwindFromSelectMeetingVC:(UIStoryboardSegue*)segue {
    
    //    [self updateUIWithDetailItem];
    
}




#pragma mark  - Notification



-(void)setNotificationwithDate:(NSDate*)date {
    
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = [NSString localizedUserNotificationStringForKey:@"Настало время встречи по объекту" arguments:nil];
    content.body =  [NSString localizedUserNotificationStringForKey:@"Моя первая нотификация" arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    
    // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:50];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute
                                     fromDate:date];
    
    
    
    NSDateComponents *time = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    triggerDate.hour = time.hour;
    triggerDate.minute = time.minute;
    
    
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate
                                                                                                      repeats:NO];
    
    NSString *identifier = @"UYLLocalNotification";
    
    UNUserNotificationCenter *center  = [UNUserNotificationCenter currentNotificationCenter];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
    
    
    
}

    



#pragma mark - Helpers



-(void)hideShowDeleteSaveButtons {
    
    if (self.hideButton == YES) {
        
        self.saveSecondButon.hidden = YES;
        self.deleteButton.hidden = YES;
      
        
    }else{
        
        self.saveSecondButon.hidden = NO;
        self.deleteButton.hidden = NO;
      
    }
}



-(void)updateLabels {
    
    self.chooseObjectLabel.text = self.chooseObjectString;
    self.nameLabel.text = self.nameString;
    self.addressLabel.text = self.addressString;
    self.priceLabel.text = self.priceString;

}



-(void)updateUIWithDetailItem {
    
    if (self.detailItem) {
        
        self.nameLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
        self.addressLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"address"]];
        self.priceLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"price"]];
        self.pictureImageView.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
    
      
    }
}


-(void)updateUIWithMeetingObject {
    
    if (self.meetingObject) {
         
         // self.datePicker.date =  [NSString stringWithFormat:@"%@",[meetingObject valueForKey:@"time"]];
         self.personNameTextField.text = [NSString stringWithFormat:@"%@",[meetingObject valueForKey:@"personName"]];
         self.personPhoneTextField.text = [NSString stringWithFormat:@"%@",[meetingObject valueForKey:@"phoneNumber"]];
         self.meetDetailsTextView.text = [NSString stringWithFormat:@"%@",[meetingObject valueForKey:@"meetDetails"]];
     
     }
}



#pragma mark - Actions

- (IBAction)datePickerValueChanged:(id)sender {

 NSDate *selectedDate = [sender date];

}
@end
