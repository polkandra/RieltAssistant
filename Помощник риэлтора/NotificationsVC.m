//
//  NotificationsVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NotificationsVC.h"

@interface NotificationsVC()

@end

@implementation NotificationsVC
@synthesize cellSelectedArray, cellText;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    self.cellSelectedArray = [[NSMutableArray alloc] init];
}

- (void) viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedRow) forKey:@"selectedTick2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) viewWillAppear:(BOOL)animated {
    self.selectedRow = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTick2"] intValue];
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.cellText = selectedCell.textLabel.text;
    
    
    if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        //return;
    }
    
    if ([cellSelectedArray containsObject:selectedCell] ) {
        [cellSelectedArray removeObject:selectedCell];
        
    }else{
        
        [cellSelectedArray addObject:selectedCell];
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
    
    if ([cellText isEqualToString:@"Отключены"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSDate *myDate = nil;
//        [userDefaults setObject:myDate forKey:@"notificationType"];
        NSString * time0 = [NSString stringWithFormat:@"Отключены"];
        [userDefaults setObject:time0 forKey:@"notificationType"];
        [userDefaults synchronize];
        
    } else if ([cellText isEqualToString:@"За 15 минут"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //NSTimeInterval interval = -60 * 15;
        //[userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
        NSString * time1 = [NSString stringWithFormat:@"За 15 минут"];
        [userDefaults setObject:time1 forKey:@"notificationType"];
        [userDefaults synchronize];
        
    }else if ([cellText isEqualToString:@"За полчаса"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        NSTimeInterval interval = -60 * 30;
        //        [userDefaults setObject:[NSNumber numberWithDouble:interval]forKey:@"notificationType"];
        NSString * time2 = [NSString stringWithFormat:@"За полчаса"];
        [userDefaults setObject:time2 forKey:@"notificationType"];
        [userDefaults synchronize];
    } else if ([cellText isEqualToString:@"За час"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        NSTimeInterval interval = -60 * 60;
        //        [userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
        NSString * time3 = [NSString stringWithFormat:@"За час"];
        [userDefaults setObject:time3 forKey:@"notificationType"];
        [userDefaults synchronize];
        
    }else if ([cellText isEqualToString:@"За 2 часа"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //        NSTimeInterval interval = -60 * 120;
        //        [userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
        NSString * time4 = [NSString stringWithFormat:@"За два часа"];
        [userDefaults setObject:time4 forKey:@"notificationType"];
        [userDefaults synchronize];
    }
    
    
    for (UITableViewCell *cell in [tableView visibleCells]) {
        if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section ) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectedCell.tag = indexPath.section;
    
}


#pragma mark - UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == self.selectedRow){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.cellText = cell.textLabel.text;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindFromNotificationsVC"]) {
        
        SettingsViewController *sVC = (SettingsViewController*)segue.destinationViewController;
        
        [[NSUserDefaults standardUserDefaults] setObject:self.cellText forKey:@"notificationsText"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sVC.notificationsCell.textLabel.text = [NSString stringWithFormat:@"%@",self.cellText];
    }
}


@end
