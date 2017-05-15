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
    
    self.tableView.allowsMultipleSelection = YES;
   
    //self.cellSelectedArray = [[NSMutableArray alloc] initWithObjects:@"Квартира",nil];
    
    self.cellSelectedArray = [[NSMutableArray alloc] init];
    
    
   
}





#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
  /*
    if (checkedCellSection == indexPath.section) {
        
        
        if (checkedCellRow == indexPath.row ) {
            
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
       
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }*/
   
}


/*- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([self.cellSelectedArray containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    return cell;
    
}*/


/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    for ( NSIndexPath* selectedIndexPath in tableView.indexPathsForSelectedRows ) {
        if ( selectedIndexPath.section == indexPath.section )
           [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO] ;
 
        
    }
 
    return indexPath ;
}*/




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   /* checkedCellRow = indexPath.row;
    checkedCellSection = indexPath.section;
    [tableView reloadData];*/
  
    
    
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
        // if we were already selected, bail and save some work.
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        
        // uncheck all visible cells.
        for (UITableViewCell *cell in [tableView visibleCells]) {
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        selectedCell.tag = indexPath.section;
        
    }
   
    else if (indexPath.section == 1){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        // if we were already selected, bail and save some work.
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark ) {
            return;
        }
        
        // uncheck all visible cells.
        for (UITableViewCell *cell in [tableView visibleCells]) {
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        selectedCell.tag = indexPath.section;
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    /*UITableViewCell *tempCell = (UITableViewCell *) [self.view viewWithTag: 55];
    NSString *flatText = tempCell.textLabel.text;*/
   
   /* UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor greenColor];
    selectedCell.selectedBackgroundView =  customColorView;*/
    
    NSString *cellText = selectedCell.textLabel.text;
    NSLog(@"text = %@",selectedCell.textLabel.text);
    
    NSString *flatText = _flatCell.textLabel.text;
    
    
    
    if ([cellSelectedArray containsObject:cellText] ) {
        [cellSelectedArray removeObject:cellText];
    
        
    }else{
        
        [cellSelectedArray addObject:cellText];
        
    }

    
    
    
    NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
    
}

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
