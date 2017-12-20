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
@synthesize tableView, cellSelectedArray, selectedCell;



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
    self.selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedTick1"];

}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.cellText = selectedCell.textLabel.text;
    if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
       // return;
    }
    
    if ([cellSelectedArray containsObject:selectedCell] ) {
        [cellSelectedArray removeObject:selectedCell];
        
    }else{
        
        [cellSelectedArray addObject:selectedCell];
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
    
    if ([self.cellText isEqualToString:@"Рубль ₽"]) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *resultString = @"₽";
        [userDefaults setObject:resultString forKey:@"currencyType"];
        [userDefaults synchronize];
        
    } else if ([self.cellText isEqualToString:@"Доллар ＄"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *resultString = @"＄";
        [userDefaults setObject:resultString forKey:@"currencyType"];
        [userDefaults synchronize];
        
    }else if ([self.cellText isEqualToString:@"Евро €"]) {
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
    
    if (indexPath.row == self.selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.cellText = cell.textLabel.text;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}



#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindFromCurrencyVC"]) {
        SettingsViewController *sVC = (SettingsViewController*)segue.destinationViewController;
        [[NSUserDefaults standardUserDefaults] setObject:self.cellText forKey:@"currencyText"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sVC.currencyLabel.text = [NSString stringWithFormat:@"%@",self.cellText];
        
    }
}






@end
