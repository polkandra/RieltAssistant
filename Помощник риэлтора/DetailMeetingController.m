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
@synthesize myMeetingObject, detailNameOfObject, detailTextView, detailTimeOfMeeting, detailItem, retrievedArray, tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self configureView];
}


-(void)configureView {
    
    if (self.myMeetingObject) {
        
        self.detailTimeOfMeeting.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"dateAndTime"]];
        self.nameOfOwner.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"personName"]];
        self.phoneOfOwner.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"phoneNumber"]];
        self.detailNameOfObject.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"objectName"]];
        self.detailTextView.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"meetDetails"]];
    }
}



#pragma mark - Actions


- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {

    NewMeetingDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMeetingDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)callButtonTapped:(UIButton *)sender {
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.phoneOfOwner.text];
    NSURL *url = [NSURL URLWithString:phoneNumber];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
    }
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromDetalMeetingToDetailObject"]) {
       
        DetailObjectController *doVC = segue.destinationViewController;
        doVC.navigationItem.hidesBackButton = YES;
        doVC.navigationItem.leftBarButtonItem = nil;
        doVC.navigationItem.rightBarButtonItem = nil;
       
        doVC.detailItem = self.detailItem;
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        doVC.navigationItem.rightBarButtonItem = flipButton;
        
    
    }else if ([segue.identifier isEqualToString:@"editFromDetailMeetingVC"]) {
        
        NewMeetingDetailViewController *nmdVC = (NewMeetingDetailViewController *)segue.destinationViewController;
        nmdVC.meetingObject = self.myMeetingObject;
        nmdVC.detailItem = self.detailItem;
       
        nmdVC.chooseObjectLabel.text = @"";
        nmdVC.nameLabel.hidden = NO;
        nmdVC.addressLabel.hidden = NO;
        nmdVC.priceLabel.hidden = NO;
        nmdVC.navigationItem.rightBarButtonItem = nil;
    
    }
}


// unwind segues from NewMeetingDetailVC with saving
- (IBAction)saveSecondButtonTapedInNewMeetingDetailVC:(UIStoryboardSegue*)segue {
    
    
}




-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
