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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.allowsMultipleSelection = YES;
    self.cellSelectedArray = [[NSMutableArray alloc] init];
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
        titleLabel.text = @"Удиницы измерения площади";
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


#pragma mark - UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
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




#pragma mark - Actions


- (IBAction)buyFullVersionButtonTapped:(UIButton *)sender {




}


- (IBAction)restorePurchasesButtonTapped:(UIButton *)sender {





}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toCurrencyVC"]){
        
        CurrencyTableViewController *sVC = segue.destinationViewController;
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        
        sVC.navigationItem.leftBarButtonItem = flipButton;
        
    }else if ([segue.identifier isEqualToString:@"toNotificationsVC"]){
        
        NotificationsVC *sVC = segue.destinationViewController;
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        
        sVC.navigationItem.leftBarButtonItem = flipButton;
    
    }
    
}


#pragma mark - Helper

- (void)setImageForButton:(UIBarButtonItem *)flipButton {
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [flipButton initWithCustomView:someButton];
}



-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
}





@end
