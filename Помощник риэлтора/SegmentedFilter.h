//
//  SegmentedFilter.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.12.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableVC.h"
#import "SegmentedCell.h"
#import "DataManager.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DetailObjectController.h"

@interface SegmentedFilter : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (nonatomic, strong) NSArray *searchResults;

- (void)configureCell:(SegmentedCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
