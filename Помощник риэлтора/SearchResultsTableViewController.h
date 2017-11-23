//
//  SearchResultsTableViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 20.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstateObjectEntity+CoreDataProperties.h"
#import "EstateObject.h"
#import "DataManager.h"
#import "SearchResultsTableViewController.h"
#import "FilteredResultCellTableViewCell.h"
#import "MainViewController.h"
#import "StyleKitName.h"
#import "DetailObjectController.h"

@interface SearchResultsTableViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *searchResults;
@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) SearchResultsTableViewController *srTVC;;
@property(strong, nonatomic) UINavigationController *nc;
@property(strong,nonatomic) UIViewController *top;
@end
