//
//  CurrencyTableViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "CurrencyTableViewController.h"

@interface CurrencyTableViewController ()

@end

@implementation CurrencyTableViewController
@synthesize tableView, cellSelectedArray;



#pragma mark - VC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsMultipleSelection = YES;
    self.cellSelectedArray = [[NSMutableArray alloc] init];
}


- (void) viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedRow) forKey:@"selectedTick1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) viewWillAppear:(BOOL)animated {
    self.selectedRow = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedTick1"] intValue];
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
    
    if ([cellText isEqualToString:@"Рубль ₽"]) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *resultString = @"₽";
        [userDefaults setObject:resultString forKey:@"currencyType"];
        [userDefaults synchronize];
        
    } else if ([cellText isEqualToString:@"Доллар ＄"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *resultString = @"＄";
        [userDefaults setObject:resultString forKey:@"currencyType"];
        [userDefaults synchronize];
        
    }else if ([cellText isEqualToString:@"Евро €"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *resultString = @"€";
        [userDefaults setObject:resultString forKey:@"currencyType"];
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
