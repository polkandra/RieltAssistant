//
//  CoreDataTableVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.07.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "MainScreenCellTableViewCell.h"

@interface CoreDataTableVC : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(MainScreenCellTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
