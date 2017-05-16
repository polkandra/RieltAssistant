//
//  FirstViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainScreenCellTableViewCell.h"
#import "StyleKitName.h"
#import "NewObjectViewController.h"
#import "EstateObject.h"
#import "DetailObjectController.h"


@interface MainViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>



@property(strong, nonatomic) NSMutableArray* myData;
@property(strong, nonatomic) NSMutableArray* myData2;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *emptyDataBaseLabel;

@property(strong, nonatomic) EstateObject* myObject;

@property (assign, nonatomic) BOOL hidden;

- (IBAction)filterTapped:(UIButton *)sender;
- (IBAction)plusTapped:(UIButton *)sender;
- (IBAction)settingsTapped:(UIButton *)sender;

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue;
- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue;

- (IBAction)unwindAfterBackButtonFromDetail:(UIStoryboardSegue*)segue;
- (IBAction)unwindAfterChangeButtonFromDetail:(UIStoryboardSegue*)segue;

@end

