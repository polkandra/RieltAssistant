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

@synthesize  myPhotosData, fetchedResultsController, tableView, detailItem, fetchedData, searchController, filteredResults;


#pragma mark - VC Lyficycle


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.emptyDataBaseLabel.hidden = YES;
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.segmentedControl.tintColor = [StyleKitName gradientColor52];
    
    
    SearchResultsTableViewController *searchResultsVC = (SearchResultsTableViewController *)self.searchController.searchResultsController;
    [self addObserver:searchResultsVC forKeyPath:@"entities" options:NSKeyValueObservingOptionNew context:nil];
   

}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setNavigationController];
    [self.segmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.filteredResults = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
   
    
    for (id object in self.filteredResults) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }
    
    if (self.filteredResults.count == 0) {
        
        self.tableView.backgroundColor = [UIColor clearColor];
        
    }else{
        
        self.tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:253/255.0 blue:248/255.0 alpha:1];
        
    }
    
}





-(void)viewWillDisappear:(BOOL)animated {
    

}


#pragma mark - UISearchResultsUpdatingDelegate

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.discription contains [cd] %@", self.searchController.searchBar.text];
    self.entities = [self.filteredResults filteredArrayUsingPredicate:predicate];

    
}




#pragma mark - UISearchController

- (UISearchController *)searchController {
    
    if (!searchController) {
        
        SearchResultsTableViewController *resultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];
        
        searchController = [[UISearchController alloc]initWithSearchResultsController:resultsController];
        searchController.searchResultsUpdater = self;
        searchController.hidesNavigationBarDuringPresentation = NO;
        searchController.delegate = self;
        searchController.obscuresBackgroundDuringPresentation = YES;
        searchController.definesPresentationContext = YES;
        searchController.searchBar.placeholder = @"введите имя объекта";
        searchController.searchBar.barTintColor = [StyleKitName gradientColor52];
        // self.tableView.tableHeaderView = searchController.searchBar;
        
    }
    return searchController;
}



#pragma mark - Helpers

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
    
}

-(void)fetchEntitiesWithPredicates:(NSPredicate*)predicates {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    [fetchRequest setPredicate:predicates];
    
    self.filterdResultsForSegmentedControl = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.entitiesForSegmentedControl = [[self.filteredResults filteredArrayUsingPredicate:predicates] mutableCopy];
    

}


- (void)setImageForButton:(UIBarButtonItem *)flipButton {
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [flipButton initWithCustomView:someButton];

}


-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
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
    }else if ([segue.identifier isEqualToString:@"toFiltering"]) {
                
        FilteringVC *fVC = (FilteringVC*)segue.destinationViewController;
        fVC.detailItem = self.detailItem;
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        
        fVC.navigationItem.leftBarButtonItem = flipButton;
        
    
     }else if ([segue.identifier isEqualToString:@"toSettingsController"]) {
         
         SettingsViewController *sVC = (SettingsViewController*)segue.destinationViewController;
         
         UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
         
         [self setImageForButton:flipButton];
         
         sVC.navigationItem.leftBarButtonItem = flipButton;
     }
    
}

#pragma mark - Actions


- (IBAction)filterTapped:(UIButton *)sender {
    
    


}

- (IBAction)plusTapped:(UIButton *)sender {
    
    
}


-(IBAction)settingsTapped:(UIButton *)sender {
    
    
    
}


- (IBAction)searchButtonTapped:(UIBarButtonItem *)sender {
    
    SearchResultsTableViewController *srTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];
    srTVC.detailItem = self.detailItem;
    
    [self presentViewController:self.searchController animated:YES completion:nil];
    
}



- (IBAction)selectedControlValueChanged:(UISegmentedControl *)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {

        case 0: {
            NSPredicate *favourite = [NSPredicate predicateWithFormat:@"isLiked == YES"];
            [self fetchEntitiesWithPredicates:favourite];
            SegmentedFilter *sfVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SegmentedResults"];
            UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
            [self setImageForButton:flipButton];
            sfVC.navigationItem.leftBarButtonItem = flipButton;
            sfVC.detailItem = self.detailItem;
            sfVC.searchResults = [[NSMutableArray alloc] init];
            sfVC.searchResults = self.entitiesForSegmentedControl;
            
            [self.navigationController pushViewController:sfVC animated:YES];
            
            break;
        }
            
        case 1: {
            NSPredicate *favourite = [NSPredicate predicateWithFormat:@"isActive == YES"];
            [self fetchEntitiesWithPredicates:favourite];
            SegmentedFilter * sfVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SegmentedResults"];
            UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
            [self setImageForButton:flipButton];
            sfVC.navigationItem.leftBarButtonItem = flipButton;
            sfVC.detailItem = self.detailItem;
            sfVC.searchResults = [[NSMutableArray alloc] init];
            sfVC.searchResults = self.entitiesForSegmentedControl;
            
            [self.navigationController pushViewController:sfVC animated:YES];
            
            break;
        }
            
        case 2: {
            NSPredicate *favourite = [NSPredicate predicateWithFormat:@"isActive == NO"];
            [self fetchEntitiesWithPredicates:favourite];
            SegmentedFilter * sfVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SegmentedResults"];
            UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
            [self setImageForButton:flipButton];
            sfVC.navigationItem.leftBarButtonItem = flipButton;
            sfVC.detailItem = self.detailItem;
            sfVC.searchResults = [[NSMutableArray alloc] init];
            sfVC.searchResults = self.entitiesForSegmentedControl;
            
            [self.navigationController pushViewController:sfVC animated:YES];
            
            break;
        }
        
        default:break;
            
    }
    
}




#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    if ([sectionInfo numberOfObjects] == 0) {
        
        self.tableView.backgroundColor = [UIColor clearColor];
        
    }else{
        
        self.tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:253/255.0 blue:248/255.0 alpha:1];
    }
    
    return [sectionInfo numberOfObjects];
}





#pragma mark - cell configuring

- (void)configureCell:(MainScreenCellTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EstateObjectEntity *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"discription"]];
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    cell.priceCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"price"]];
   // cell.priceCellLabel.textColor = [UIColor whiteColor];
    cell.addressCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"address"]];
    cell.addressCellLabel.textColor = [UIColor whiteColor];
    cell.ownerCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"owner"]];
    cell.ownerCellLabel.textColor = [UIColor whiteColor];
    cell.imageViewCell.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];
    
    if (object.isLiked == YES) {
        
        cell.likeView.image = [UIImage imageNamed:@"likeRed"];
        
    }else{
        
        cell.likeView.image = nil;
    }
    
    if (object.isActive == YES) {
        
        cell.statusView.image = [UIImage imageNamed:@"active"];
        
    }else{
        
        cell.statusView.image = [UIImage imageNamed:@"finished"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
   
  
}

@end
