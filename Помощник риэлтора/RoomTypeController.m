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



/*- (void) viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedRow) forKey:@"selectedTick5"];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedRow2) forKey:@"selectedTick6"];
    [[NSUserDefaults standardUserDefaults] setObject:self.cellSelectedArray1 forKey:@"ticksArray1"];
    [[NSUserDefaults standardUserDefaults] setObject:self.cellSelectedArray2 forKey:@"ticksArray2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) viewWillAppear:(BOOL)animated {
    self.selectedRow = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTick5"] intValue];
    self.selectedRow2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTick6"] intValue];
    
//    self.cellSelectedArray1 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ticksArray1"] mutableCopy];
//    self.cellSelectedArray2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ticksArray2"] mutableCopy ];
    
    NSMutableArray *array = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ticksArray1"] mutableCopy];
    NSMutableArray *array2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ticksArray2"] mutableCopy];

    self.cellSelectedArray1 =  [[NSMutableArray alloc] initWithArray:array];
    self.cellSelectedArray2 =  [[NSMutableArray alloc] initWithArray:array2];
}*/


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
       
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            //return;
        }
        
        if ([self.cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            
            [self.cellSelectedArray removeObject:selectedCell.textLabel.text];
            
        }else{
            
            [self.cellSelectedArray addObject:selectedCell.textLabel.text];
            NSLog(@"%lu",(unsigned long) self.cellSelectedArray.count);
            
        }
        
        
        for (UITableViewCell *cell in [tableView visibleCells]) {
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section ) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
        }
        
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedCell.tag = indexPath.section;
        
    }else if (indexPath.section == 1) {
      
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
       
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark ) {
            
           // return;
        }
        
        if ([self.cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [self.cellSelectedArray removeObject:selectedCell.textLabel.text];
            
        }else{
            [self.cellSelectedArray addObject:selectedCell.textLabel.text];
        }
        
        
        // uncheck all visible cells.
        for (UITableViewCell *cell in [tableView visibleCells]) {
            
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        selectedCell.tag = indexPath.section;
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
        NSLog(@"%lu",(unsigned long)self.cellSelectedArray.count);
        
    }
    
}


#pragma mark - UITableViewDataSource


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    if (section == 0) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Тип объекта";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 1) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Тип действия";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }
    return headerView;

}

#pragma mark - UITableViewDataSource


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == self.selectedRow){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
       
        }
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == self.selectedRow2){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}*/


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindAfterBackTapped"]) {
        
        NewObjectViewController *controller = segue.destinationViewController;
        controller.myData1 = cellSelectedArray;
       
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
}



-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"unwindAfterSaveTapped"]) {
        
       // if ([cellSelectedArray count] == 0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Внимание" message:@"Введите параметры" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            return NO;
        }
        
   // }
    return YES;
}











@end
