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
@synthesize myMeetingObject, detailTimeOfMeeting, detailItem, retrievedArray, tableView, telString;


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   
    self.pic.layer.masksToBounds = YES;
    self.pic.layer.cornerRadius  = self.pic.frame.size.width / 2;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self configureView];
}




-(void)configureView {
    
    if (self.myMeetingObject) {
        
        self.detailTimeOfMeeting.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"time"]];
        self.detailDateOfMeeting.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"date"]];
        self.nameOfOwner.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"personName"]];
        self.phoneOfOwner.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"phoneNumber"]];
       // self.detailNameOfObject.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"objectName"]];
        self.detailsLabel.text = [NSString stringWithFormat:@"%@",[myMeetingObject valueForKey:@"meetDetails"]];
        self.pic.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
    }
}



#pragma mark - Actions


- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {

    NewMeetingDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMeetingDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)callButtonTapped:(UIButton *)sender {
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.phoneOfOwner.text];
    
    
    if (self.phoneOfOwner.text.length > 0) {
        self.telString = [@"telprompt://" stringByAppendingString:self.phoneOfOwner.text];
    }else{
        return;
    }
    
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
        
        [self setImageForButton:flipButton];
        doVC.navigationItem.leftBarButtonItem = flipButton;
        
        
    }else if ([segue.identifier isEqualToString:@"editFromDetailMeetingVC"]) {
        
        NewMeetingDetailViewController *nmdVC = (NewMeetingDetailViewController *)segue.destinationViewController;
        nmdVC.meetingObject = self.myMeetingObject;
        nmdVC.detailItem = self.detailItem;
       
        nmdVC.chooseObjectLabel.text = @"";
        nmdVC.nameLabel.hidden = NO;
        nmdVC.addressLabel.hidden = NO;
        nmdVC.priceLabel.hidden = NO;
        nmdVC.navigationItem.rightBarButtonItem = nil;
    
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        nmdVC.navigationItem.leftBarButtonItem = flipButton;
        
    
    
    }
}


// unwind segues from NewMeetingDetailVC with saving
- (IBAction)saveSecondButtonTapedInNewMeetingDetailVC:(UIStoryboardSegue*)segue {
    
    
}


#pragma mark - Helper

-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
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



@end
