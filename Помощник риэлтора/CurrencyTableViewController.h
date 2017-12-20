//
//  CurrencyTableViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface CurrencyTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *cellSelectedArray;
@property(assign, nonatomic) NSInteger selectedRow;
@property(strong, nonatomic) NSString *cellText;
@property(strong, nonatomic) UITableViewCell *selectedCell;

@end
