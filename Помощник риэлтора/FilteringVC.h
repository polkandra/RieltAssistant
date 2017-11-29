//
//  FilteringVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "FilteredResultsVC.h"

@interface FilteringVC : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic)  NSMutableArray *cellSelectedArray;
@property(strong, nonatomic) NSArray* filteredResults;
@property(strong, nonatomic) NSMutableArray* entities;


@property (weak, nonatomic) IBOutlet UITableViewCell *rentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sellCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *flatCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *houseCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nonLivingCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *roomCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *earthCell;




@property (strong, nonatomic) EstateObjectEntity *detailItem;


- (IBAction)startSearch:(UIBarButtonItem *)sender;

@end
