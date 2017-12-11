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
@synthesize tableView, cellSelectedArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    self.cellSelectedArray = [[NSMutableArray alloc] init];
}



#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell] ) {
            [cellSelectedArray removeObject:selectedCell];
            
        }else{
            
            [cellSelectedArray addObject:selectedCell];
            NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
            
        }
        
        for (UITableViewCell *cell in [tableView visibleCells]) {
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section ) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
        }
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedCell.tag = indexPath.section;
        
    }
    
}

@end
