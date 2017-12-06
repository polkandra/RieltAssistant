//
//  SelectMeetingOblectVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SelectMeetingOblectVC.h"

@interface SelectMeetingOblectVC ()

@end

@implementation SelectMeetingOblectVC
@synthesize fetchedResultsController, tableView;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationController];

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"unwindFromSelectMeetingVC"]) {
        
        NewMeetingDetailViewController *dmVC = (NewMeetingDetailViewController *)segue.destinationViewController;
        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        EstateObjectEntity *selectedEntity = [[self fetchedResultsController] objectAtIndexPath:selectedPath];
        dmVC.detailItem = selectedEntity;
        dmVC.chooseObjectString = @"";

        
    }
}


#pragma mark - Helpers


-(void)setNavigationController {
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
   // [self.navigationItem setTitle:@"Мои объекты"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:19]}];
    
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



#pragma mark - FRC

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
    
    return aFetchedResultsController;
}





#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectMeetingCell *cell = (SelectMeetingCell*) [self.tableView dequeueReusableCellWithIdentifier:@"selectMeetingCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


#pragma mark - Cell configuring

- (void)configureCell:(SelectMeetingCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EstateObjectEntity *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameOfMeeting.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"discription"]];
   // cell.nameOfMeeting.textColor = [UIColor whiteColor];
    cell.priceOfMetting.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"price"]];
    //cell.priceOfMetting.textColor = [UIColor whiteColor];
    cell.addressOfMeeting.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"address"]];
   // cell.addressOfMeeting.textColor = [UIColor whiteColor];
    cell.meetingPicture.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];
   
    cell.backgroundColor = [UIColor clearColor];
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}









@end
