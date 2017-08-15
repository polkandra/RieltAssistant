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
#import "EbmeddedImageController.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "CoreDataTableVC.h"


@interface MainViewController : CoreDataTableVC  <UITableViewDataSource, UITableViewDataSource, NSKeyedArchiverDelegate, AddArrayDelegate>



@property(strong, nonatomic) NSMutableArray* myPhotosData;
@property(strong, nonatomic) NSMutableArray* fetchedData;
@property(strong, nonatomic) NSMutableArray* fetchedArrayWithUsersPics;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *emptyDataBaseLabel;


@property(strong, nonatomic) EstateObjectEntity *object;



@property (assign, nonatomic) BOOL hidden;

- (IBAction)filterTapped:(UIButton *)sender;
- (IBAction)plusTapped:(UIButton *)sender;
- (IBAction)settingsTapped:(UIButton *)sender;

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue;
- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue;

- (IBAction)unwindAfterBackButtonFromDetail:(UIStoryboardSegue*)segue;
- (IBAction)unwindAfterChangeButtonFromDetail:(UIStoryboardSegue*)segue;

@end

