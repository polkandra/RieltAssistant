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
        
        NSError *error;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
        self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
        
        for (id object in self.retrievedArray) {
            if ([object isKindOfClass:[EstateObjectEntity class]]) {
                self.detailItem = ((EstateObjectEntity *)object);
            }
        }
    
        
        DetailObjectController *doVC = segue.destinationViewController;
        doVC.navigationItem.hidesBackButton = YES;
        doVC.navigationItem.leftBarButtonItem = nil;
        doVC.navigationItem.rightBarButtonItem = nil;
        //doVC.shareBarButtonItem = nil;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSInteger index = [self.retrievedArray indexOfObject:self.detailItem];
        EstateObjectEntity *estateEntity = [self.retrievedArray objectAtIndex:index];
        self.detailItem = [self.retrievedArray objectAtIndex:index];
        
        
        
        
        doVC.detailItem = estateEntity;
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        doVC.navigationItem.rightBarButtonItem = flipButton;
        
    }
}


#pragma mark - Helpers

-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
