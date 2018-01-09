//
//  SettingsViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyTableViewController.h"
#import "NotificationsVC.h"
#import "InAppManager.h"
#import <StoreKit/StoreKit.h>
#import "NewObjectViewController.h"
@interface SettingsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *currencyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *notificationsCell;

//@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timeToMeetLabel;

@property (strong, nonatomic) NSMutableArray *cellSelectedArray;
@property (strong, nonatomic) NSString *cellText;
@property(assign, nonatomic) NSInteger selectedRow;

@end
