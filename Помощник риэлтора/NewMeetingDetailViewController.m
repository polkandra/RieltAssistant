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
   
    //self.tableView.backgroundColor = [StyleKitName gradientColor8];
    [self setDelegatesForTextFields];
    [self hideShowDeleteSaveButtons];
    [self addGestureRecognizer];
    
    self.pictureImageView.layer.masksToBounds = YES;
    self.pictureImageView.layer.cornerRadius  = self.pictureImageView.frame.size.width/2.0;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self updateLabels];
    [self updateUIWithMeetingObject];
    [self updateUIWithDetailItem];
}




#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    if (section == 0) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Объект";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 1) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Дата и время встречи";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 2) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Данные клиента";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 3) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Заметки по встрече";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
        
    }

    return headerView;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
        
        [self setNotificationwithDate:self.datePicker.date];
       // [self fetchEstateObjectEntity];
        
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
        
        
        if (self.personNameTextField.text.length > 0) {
            
            object.personName = self.personNameTextField.text;
       
        }else{
            
            object.personName = @"Цена не указана";
        }
        
        
        if (self.personPhoneTextField.text.length > 0) {
            
            object.phoneNumber  = self.personPhoneTextField.text;
            
        }else{
            
            object.phoneNumber  = @"Телефон не указан";
        }
        
        
        object.dateAndTime = dateAndTime;
        
        object.meetDetails = self.meetDetailsTextView.text;
        object.estateObject = self.detailItem;
        object.picture = detailItem.picture;
        
        
        mVC.detailItem = self.detailItem;
       
        if (self.meetDetailsTextView.text.length > 0) {
            
            object.meetDetails = self.meetDetailsTextView.text;
            
        }else{
            
            object.meetDetails = @"Нет заметок по встрече";
            
        }
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        
    }else if ([segue.identifier isEqualToString:@"saveSecondButtonTapedInNewMeetingDetailVC"]) {
        
       // [self fetchEstateObjectEntity];
        
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
        
    
    
     }else if ([segue.identifier isEqualToString:@"toChoseEntityResults"]) {
    

         SelectMeetingOblectVC *sVC = (SelectMeetingOblectVC*)segue.destinationViewController;
         
         UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
         
         [self setImageForButton:flipButton];
         
         sVC.navigationItem.leftBarButtonItem = flipButton;

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
    

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute
                                     fromDate:date];
    
    
    
    NSDateComponents *time = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    triggerDate.hour = time.hour;
    triggerDate.minute = time.minute;
    
    
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
    
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

    
#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.personPhoneTextField resignFirstResponder];
    [self.personPhoneTextField resignFirstResponder];

    return NO;
    
}



#pragma mark - UITapGestureRecognizer Method

-(void)addGestureRecognizer {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}


- (void)hideKeyboard {
    
    [self.view endEditing:YES];
}





#pragma mark - Helpers

-(void)setDelegatesForTextFields {
   
    self.personNameTextField.delegate = self;
    self.personPhoneTextField.delegate = self;
   
}


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


- (void)setImageForButton:(UIBarButtonItem *)flipButton {
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [flipButton initWithCustomView:someButton];
}


-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
}



//-(void)fetchEstateObjectEntity {
//
//    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"EstateObjectEntity" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entity];
//    [request setResultType:NSDictionaryResultType];
//    [request setReturnsDistinctResults:YES];
//    [request setPropertiesToFetch:@[@"longitude", @"latitude", @"picture", @"discription", @"price", @"actionByProperty", @"address", @"kitchenArea", @"livingArea", @"owner", @"phoneNumber", @"roomQuantity", @"typeOfProperty", @"wholeArea"]];
//    
//    NSError *error;
//    
//    self.retrievedArray = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error];
//    
//    for (NSDictionary *location in self.retrievedArray) {
//        
//        point.latitude  = [location[@"latitude"] doubleValue];
//    }
//}




#pragma mark - Actions

- (IBAction)datePickerValueChanged:(id)sender {

 NSDate *selectedDate = [sender date];

}
@end
