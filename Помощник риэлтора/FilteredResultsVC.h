//
//  FilteredResultsVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableVC.h"
#import "FilteredCell.h"
#import "DataManager.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "FilteringVC.h"
#import "DetailObjectController.h"

@interface FilteredResultsVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (nonatomic, strong) NSArray *searchResults;

- (void)configureCell:(FilteredCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
