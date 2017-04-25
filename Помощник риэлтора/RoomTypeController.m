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
@synthesize tableView, checkedCellRow, checkedCellSection;


#pragma mark - VC Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
  
}



#pragma mark - UITableViewDataSource

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    return cell;
}*/



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
    
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

   //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark - Segues


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.myObject = [[EstateObject alloc] init];
    
    
}

@end
