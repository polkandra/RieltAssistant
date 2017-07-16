//
//  RoomTypeController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "RoomTypeController.h"

@interface RoomTypeController ()

@end

@implementation RoomTypeController
@synthesize tableView, cellSelectedArray;


#pragma mark - VC Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
   
    self.cellSelectedArray = [[NSMutableArray alloc] init];
    
    
   
}





#pragma mark - UITableViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [cellSelectedArray removeObject:selectedCell.textLabel.text];
            
            
        }else{
            
            [cellSelectedArray addObject:selectedCell.textLabel.text];
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
    
    else if (indexPath.section == 1) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark ) {
            
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [cellSelectedArray removeObject:selectedCell.textLabel.text];
            
            
        }else{
            
            [cellSelectedArray addObject:selectedCell.textLabel.text];
            
        }
        

        // uncheck all visible cells.
        for (UITableViewCell *cell in [tableView visibleCells]) {
            
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
        }
        selectedCell.tag = indexPath.section;
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
    
}




#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindAfterSaveTapped"]) {
        
        
        
        NewObjectViewController *controller = segue.destinationViewController;
        controller.myData = cellSelectedArray;
        
        
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
}



-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"unwindAfterSaveTapped"]) {
        
        if ([cellSelectedArray count] == 0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Внимание" message:@"Введите параметры" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            return NO;
        }
        
    }
    return YES;
}











@end
