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
@synthesize cellSelectedArray;



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
        NSString *cellText = selectedCell.textLabel.text;
        
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell] ) {
            [cellSelectedArray removeObject:selectedCell];
            
        }else{
            
            [cellSelectedArray addObject:selectedCell];
            NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
            
        }
        
       
        if ([cellText isEqualToString:@"Отключены"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSDate *myDate = nil;
            [userDefaults setObject:myDate forKey:@"notificationType"];
            [userDefaults synchronize];
            
        } else if ([cellText isEqualToString:@"За 15 минут"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSTimeInterval interval = -60 * 15;
            [userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
            [userDefaults synchronize];
            
        }else if ([cellText isEqualToString:@"За полчаса"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSTimeInterval interval = -60 * 30;
            [userDefaults setObject:[NSNumber numberWithDouble:interval]forKey:@"notificationType"];
            [userDefaults synchronize];
        } else if ([cellText isEqualToString:@"За час"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSTimeInterval interval = -60 * 60;
            [userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
            [userDefaults synchronize];
            
        }else if ([cellText isEqualToString:@"За 2 часа"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSTimeInterval interval = -60 * 120;
            [userDefaults setObject:[NSNumber numberWithDouble:interval] forKey:@"notificationType"];
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
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    
    return cell;
}



@end
