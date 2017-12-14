//
//  SecondViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MeetingsViewController.h"



@interface MeetingsViewController ()

@end

@implementation MeetingsViewController
@synthesize fetchedResultsController, tableView, meetingObject, detailItem, retrievedArray;

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self setNavigationController];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.retrievedArray = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    for (id object in self.retrievedArray) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }
    
    

}

#pragma mark - Navigation

// Unwind segue from NewMeetingVC

- (IBAction)unwindFromNewMeetengsDetailVC:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
       
        _disclaimerLabel.hidden = YES;
  
        
    }
}

// unwind segues from NewMeetingDetailVC with deletion
- (IBAction)deleteButtonTapedInNewMeetingDetailVC:(UIStoryboardSegue*)segue {
    
    
}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetailMeetingVC"]) {
        
        DetailMeetingController *controller = (DetailMeetingController  *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MeetingObjectEntity *selectedEntity = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        controller.myMeetingObject = selectedEntity;
        controller.detailItem = selectedEntity.estateObject;
        
        
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        controller.navigationItem.leftBarButtonItem = flipButton;
    
    
    }else if ([segue.identifier isEqualToString:@"toNewMeetingDetailVC"]) {
        
        NewMeetingDetailViewController *nmdVC = (NewMeetingDetailViewController *)segue.destinationViewController;
        nmdVC.nameLabel.text = @"";
        nmdVC.priceLabel.text = @"";
        nmdVC.addressLabel.text = @"";
        nmdVC.chooseObjectString = @"Выберите объект";
        nmdVC.hideButton = YES;
   
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
       
        [self setImageForButton:flipButton];
        
        nmdVC.navigationItem.leftBarButtonItem = flipButton;
    }
}




#pragma  mark - FRC

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MeetingObjectEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    
   // [fetchRequest setIncludesSubentities:YES];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:10];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *date = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSSortDescriptor *time = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    
    NSArray *sortDescriptors = @[date, time];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
   
    if ([sectionInfo numberOfObjects] == 0) {
        
        self.tableView.backgroundColor = [UIColor clearColor];
        
    }else{
        
        self.tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:253/255.0 blue:248/255.0 alpha:1];
    }
   
    return [sectionInfo numberOfObjects];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}


/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    return [self.sectionDateFormatter stringFromDate:dateRepresentingThisDay];
}*/



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MeetingCell";
    
    MeetingsCell *cell = (MeetingsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}


-(void)configureCell:(MeetingsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    MeetingObjectEntity* object = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"date"]];
   // cell.dateLabel.textColor = [UIColor whiteColor];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"time"]];
   // cell.timeLabel.textColor = [UIColor whiteColor];
    
    cell.objectNameLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"objectName"]];;
    cell.objectNameLabel.textColor = [UIColor whiteColor];
    
    cell.personNameLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"personName"]];;
    cell.personNameLabel.textColor = [UIColor whiteColor];
    //cell.objectPicture.image = [[UIImage alloc] initWithData:[self.retrievedArray objectAtIndex:0]];
    cell.objectPicture.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];

 
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Helper

-(void)setNavigationController {
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self.navigationItem setTitle:@"Мои встречи"];
    
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


-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
 
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

@end
