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
    
    self.cellSelectedArray = [[NSMutableArray alloc] init];
    self.myData = [NSMutableArray arrayWithObjects:@"1 комната",@"2 комнаты",@"3 комнаты",@"4 комнаты",@"5 комнат и более", nil];
}



#pragma mark - UITableViewDataSource

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}*/


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;






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
    
    
   /* [[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark;
    
    self.cellSelectedArray = [self.tableView indexPathsForSelectedRows];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in cellSelectedArray) {
        
        
        [array addObject: self.myData[indexPath.row]];
    }*/
    
    }



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

   //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}



#pragma mark - Segues


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.myObject = [[EstateObject alloc] init];
    
    
    //self.myObject.estateType = [self.array firstObject];
   // self.myObject.typeOfActionByEstate = [self.cellSelectedArray lastObject];
    
    
    
}

@end
