//
//  DetailMeetingController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 05.07.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "DetailMeetingController.h"

@interface DetailMeetingController ()

@end

@implementation DetailMeetingController
@synthesize myMeetingObject, detailNameOfObject, detailTextView, detailTimeOfMeeting;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.detailNameOfObject.text = myMeetingObject.objectName;
   
    self.detailTimeOfMeeting.text = myMeetingObject.dateAndTime;
    self.nameOfOwner.text = myMeetingObject.personName;
    self.phoneOfOwner.text = myMeetingObject.phoneNumber;

}






#pragma mark - Table view data source


@end
