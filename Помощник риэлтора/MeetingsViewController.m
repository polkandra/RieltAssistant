//
//  SecondViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MeetingsViewController.h"



@interface MeetingsViewController ()

@end

@implementation MeetingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   


    self.myMeetingsDetailsData = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}




#pragma mark - Unwind segue from NewMeetingVC



- (IBAction)unwindFromNewMeetengsDetailVC:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
        
        NewMeetingDetailViewController *controller = segue.sourceViewController;
        
        MeetingObject* newObject = controller.meetingObject;
        
        [self.myMeetingsDetailsData addObject:newObject];
        
        _disclaimerLabel.hidden = YES;

       
        NSLog(@"my aaaaray = %@",self.myMeetingsDetailsData);
        
        
        [self.tableView reloadData];
        
        
        
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetailMeetingVC"]) {
        
        DetailMeetingController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        controller.myMeetingObject = [self.myMeetingsDetailsData objectAtIndex:indexPath.row];
        
    }
}




#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myMeetingsDetailsData count] ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    static NSString *CellIdentifier = @"MeetingCell";
   
    MeetingsCell *cell = (MeetingsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MeetingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MeetingObject* object = [self.myMeetingsDetailsData objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = object.date;
    cell.dateLabel.textColor = [UIColor whiteColor];
   
    cell.timeLabel.text = object.time;
    cell.timeLabel.textColor = [UIColor whiteColor];
    
    cell.objectNameLabel.text = object.objectName;
    cell.objectNameLabel.textColor = [UIColor whiteColor];
    
    cell.personNameLabel.text = object.personName;
    cell.personNameLabel.textColor = [UIColor whiteColor];
    
    
    return cell;

  
}

#pragma mark - UITableViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.myMeetingsDetailsData removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}



@end
