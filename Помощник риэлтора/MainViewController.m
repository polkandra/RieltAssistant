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

@synthesize  myPhotosData, fetchedResultsController, tableView, object, fetchedData;


#pragma mark - VC Lyficycle


- (void)viewDidLoad {
    
        
    [super viewDidLoad];
    
    self.emptyDataBaseLabel.hidden = YES;
    
    
    
    
   // NSLog(@"all my photos in myPhotosData = %@",self.myPhotosData);
   
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}





-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setNavigationController];
 
}



-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    /*NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.fetchedData = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];*/
  
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
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:19]}];
    
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
    
   /* NSManagedObjectContext *moc = [[DataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"EstateObjectEntity" inManagedObjectContext:moc]];
    
    NSError *error = nil;
    NSArray *objects = [moc executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *object in objects) {
        [moc deleteObject:object];
    }
    NSError *error2 = nil;
    [moc save:&error2];*/
    

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
        
    }
}



#pragma mark - Actions


- (IBAction)filterTapped:(UIButton *)sender {
    
    
}

- (IBAction)plusTapped:(UIButton *)sender {
    
    
}


-(IBAction)settingsTapped:(UIButton *)sender {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
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


- (void)arrayChosen:(NSArray *)array {
    if (!_fetchedArrayWithUsersPics) {
        _fetchedArrayWithUsersPics = [[NSMutableArray alloc] init];
    }
    [_fetchedArrayWithUsersPics insertObject:array atIndex:0];
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
