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



#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myMeetingsDetailsData count] ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row % 2 == 1) {
        return 40.0;
    } else {
        return 2.0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.row % 2 == 1)
    {
        static NSString *CellIdentifier = @"MeetingCell";
        MeetingsCell *cell = (MeetingsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EmptyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
        
        cell.backgroundColor = [UIColor greenColor];
        
        return cell;
        
    } else {
        
        static NSString *CellIdentifier2 = @"EmptyCell";
        EmptyCell *cell2 = (EmptyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell2 == nil) {
            cell2 = [[EmptyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier2];
        }
        cell2.backgroundColor = [UIColor clearColor];
        cell2.userInteractionEnabled = NO;
        return cell2;
    }
    
}

 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.myMeetingsDetailsData removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}





#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




#pragma mark - Unwind segue from NewMeetingVC



- (IBAction)unwindFromNewMeetengsDetailVC:(UIStoryboardSegue*)segue {


}


@end
