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
@synthesize tableView, checkedCellRow, checkedCellSection, cellSelectedArray;


#pragma mark - VC Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    tableView.allowsMultipleSelection = YES;
   
    self.cellSelectedArray = [[NSMutableArray alloc] init];
    
   
    
}





#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
   if (checkedCellSection == indexPath.section) {
        
        if (checkedCellRow == indexPath.row) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
       
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
   }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    checkedCellRow = indexPath.row;
    checkedCellSection = indexPath.section;
    [tableView reloadData];
    
    
    if ([indexPath row] >= 0) {
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        NSString *cellText = selectedCell.textLabel.text;
        
        NSLog(@"text = %@",selectedCell.textLabel.text);
        
        if ([cellSelectedArray containsObject:cellText]) {
            [cellSelectedArray removeObject:cellText];
            
            
        }else{
            
            [cellSelectedArray addObject:cellText];
            
        }
    }
    NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

   //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}





#pragma mark - Segues


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindAfterSaveTapped"]) {
        

        
        NewObjectViewController *controller = segue.destinationViewController;
        controller.myData = cellSelectedArray;
        
        
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
           }
}



@end
