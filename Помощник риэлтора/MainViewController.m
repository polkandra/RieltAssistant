//
//  FirstViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@end


@implementation MainViewController

@synthesize  myPhotosData, fetchedResultsController, tableView, detailItem, fetchedData, searchBar, searchController, delegate, filteredResults;


#pragma mark - VC Lyficycle


- (void)viewDidLoad {
    
        
    [super viewDidLoad];
    [self setSearchController];
   
   // [self filter:@""];
   
    self.emptyDataBaseLabel.hidden = YES;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    SearchResultsTableViewController *searchResults = (SearchResultsTableViewController *)self.searchController.searchResultsController;
    [self addObserver:searchResults forKeyPath:@"results" options:NSKeyValueObservingOptionNew context:nil];
}



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavigationController];
    
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"EstateObjectEntity" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:YES];
    [request setPropertiesToFetch:@[@"discription"]];
    
    NSError *error;
    
    self.filteredResults = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error];
    
}



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
   

}

#pragma mark - UISearchControllerDelegate








#pragma mark - UISearchResultsUpdatingDelegate


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // filter the search results
   
    
   // NSString* filter = @"%K CONTAINS[cd] %@";
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"EstateObjectEntity LIKE[c] %@", self.searchController.searchBar.text];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.discription contains [cd] %@", self.searchController.searchBar.text];
    self.entities = [self.filteredResults filteredArrayUsingPredicate:predicate];
    
    
    
    /*NSString *searchString = self.searchController.searchBar.text;
    [self updateFilteredContentForAirlineName:searchString];
    
    if (self.searchController.searchResultsController) {
        
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
        SearchResultsTableViewController *vc = (SearchResultsTableViewController *)navController.topViewController;
        
        
        vc.searchResults = filteredResults;
        
        
        [vc.tableView reloadData];
    }*/
    
}

/*- (void)updateFilteredContentForAirlineName:(NSString *)entityName {

    if (entityName == nil) {
        
        self.entities = [self.filteredResults mutableCopy];
    
    } else {
        
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
               
        for (NSDictionary *entity in self.filteredResults) {
            if ([entity[@"discription"] containsString:entityName]) {
                
                NSString *str = [NSString stringWithFormat:@"%@", entity[@"discription"]];
                [searchResults addObject:str];
            }
            
            self.entities = searchResults;
        }
    }
}*/




/*-(void)filter:(NSString*)text {
    
    self.entities = [[NSMutableArray alloc] init];
    
    // Create our fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Define the entity we are looking for
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EstateObjectEntity" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Define how we want our entities to be sorted
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"discription" ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // If we are searching for anything...
    if(text.length > 0) {
    
        // Define how we want our entities to be filtered
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name CONTAINS[c] %@)",text];
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    
    // Finally, perform the load
    NSArray* loadedEntities = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.filteredResults = [[NSMutableArray alloc] initWithArray:loadedEntities];
    
    [self.tableView reloadData];
}


#pragma mark - UITextFieldDelegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text {

    [self filter:text];
}*/


#pragma mark - Helpers

-(void)setSearchController {
    
    SearchResultsTableViewController *searchResultNC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultNC];
    self.searchController.searchResultsUpdater = self;
    self.searchBar.delegate = self;
    self.searchBar.barTintColor = [StyleKitName gradientColor7];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"введите имя объекта";
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = searchController;
    } else {
        
    }
    self.searchController.definesPresentationContext = YES;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,
                                                       self.searchController.searchBar.frame.origin.y,
                                                       self.searchController.searchBar.frame.size.width, 44.0);
    //self.tableView.tableHeaderView = self.searchController.searchBar;
    
}





-(void)setNavigationController {
   
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self.navigationItem setTitle:@"Мои объекты"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"BloggerSans" size:23]}];
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
    
    // making nav bar translucent
    /*[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     self.navigationController.navigationBar.translucent = YES;*/
    //
    
}


#pragma mark - Unwind Segues


// unwind segue from NewObject VC
- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMain"]) {
        _emptyDataBaseLabel.hidden = YES;
        
    }
}


// unwind segue from NewObject VC
- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue {
    
    
}

// unwind segue from DetailObject VC
- (IBAction)unwindAfterBackButtonFromDetail:(UIStoryboardSegue*)segue {
   
    

}

// unwind segue from DetailObject VC
- (IBAction)unwindAfterChangeButtonFromDetail:(UIStoryboardSegue*)segue {
    
}


// unwind segue from NewObjectVC with deletion
- (IBAction)removeButtonTaped:(UIStoryboardSegue*)segue {
    
   
}

#pragma mark  Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        
        DetailObjectController *doc = (DetailObjectController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EstateObjectEntity *selectedEntity = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        doc.detailItem = selectedEntity;
        
    }else if ([segue.identifier isEqualToString:@"toNewObject"]) {
        
        NewObjectViewController *newVC = (NewObjectViewController *)segue.destinationViewController;
        newVC.navigationItem.title = @" Новый объект";
        newVC.hideButton = YES;
        // newVC.detailItem = self.detailItem;
    }
}



#pragma mark - Actions


- (IBAction)filterTapped:(UIButton *)sender {
    
    


}

- (IBAction)plusTapped:(UIButton *)sender {
    
    
}


-(IBAction)settingsTapped:(UIButton *)sender {
    
    
}






- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EstateObjectEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:10];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *discription = [[NSSortDescriptor alloc] initWithKey:@"discription" ascending:NO];
    NSSortDescriptor *price = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
    
    NSArray *sortDescriptors = @[discription, price];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    //    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    //    [NSFetchedResultsController load];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}






#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainScreenCellTableViewCell *cell = (MainScreenCellTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

#pragma mark - cell configuring

- (void)configureCell:(MainScreenCellTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EstateObjectEntity *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"discription"]];
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    cell.priceCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"price"]];
    cell.priceCellLabel.textColor = [UIColor whiteColor];
    cell.addressCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"address"]];
    cell.addressCellLabel.textColor = [UIColor whiteColor];
    cell.ownerCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"owner"]];
    cell.ownerCellLabel.textColor = [UIColor whiteColor];
    
    cell.imageViewCell.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    /*UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 374, 30)];
    
    view.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:view];*/
  
}

@end
