//
//  SettingsViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize tableView, cellSelectedArray;

static NSString* alreadyBoughtMessage = @"Уже куплено";

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.allowsMultipleSelection = YES;
    self.cellSelectedArray = [[NSMutableArray alloc] init];

    [InAppManager sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unlockProduct1) name:@"feature1Purchased" object:nil];
   
    
}

- (void) viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedRow) forKey:@"selectedTick"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void) viewWillAppear:(BOOL)animated {
    self.selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedTick"];
    self.notificationsCell.textLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"notificationType"];
    self.currencyCell.textLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"currencyType"];
}



#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    if (section == 0) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Валюта";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 1) {
       [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @" Единицы измерения площади";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 2) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Уведомления";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 3)  {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Другие";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        if (indexPath.row == self.selectedRow){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (indexPath.section == 1) {
        self.selectedRow = indexPath.row;
        [self.tableView reloadData];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *cellText = selectedCell.textLabel.text;
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            //return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell] ) {
            [cellSelectedArray removeObject:selectedCell];
            
        }else{
            
            [cellSelectedArray addObject:selectedCell];
            NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
            
        }
            if ([cellText isEqualToString:@"Футы"]) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:cellText forKey:@"lengthType"];
                [userDefaults synchronize];
                
            } else if ([cellText isEqualToString:@"Метры"]) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:cellText forKey:@"lengthType"];
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
    
}




#pragma mark - Actions


- (IBAction)buyFullVersionButtonTapped:(UIButton *)sender withMessage:(NSString*)theMessage {

//    if( [theMessage isEqualToString:alreadyBoughtMessage]) {
//
//        [sender addTarget:self action:@selector(doNothing) forControlEvents:UIControlEventTouchUpInside];
//
//    }else{
    
        [sender addTarget:[InAppManager sharedManager] action:@selector(buyFeature1) forControlEvents:UIControlEventTouchUpInside];
  //  }

}


- (IBAction)restorePurchasesButtonTapped:(UIButton *)sender {





}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toCurrencyVC"]){
        
       // CurrencyTableViewController *sVC = segue.destinationViewController;
        
        
    }else if ([segue.identifier isEqualToString:@"toNotificationsVC"]){
        
    }
    
}

// unwind segue from unwindFromNotificationsVC
- (IBAction)unwindFromNotificationsVC:(UIStoryboardSegue*)segue {
    
}


// unwind segue from unwindFromCurrencyVC
- (IBAction)unwindFromCurrencyVC:(UIStoryboardSegue*)segue {
    
}



#pragma mark - Helper

-(void)doNothing {
    
    NSLog(@"Do Nothing");
    
}

-(void) unlockProduct1 {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Object" bundle:nil];
    NewObjectViewController *noVC = [storyboard instantiateViewControllerWithIdentifier:@"New"];
    noVC.isBought = YES;

}


@end
