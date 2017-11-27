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
@property(strong, nonatomic) NSArray* entities;


@property (strong, nonatomic) EstateObjectEntity *detailItem;


- (IBAction)startSearch:(UIBarButtonItem *)sender;

@end
