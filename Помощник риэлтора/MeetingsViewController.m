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
@synthesize fetchedResultsController, tableView, meetingObject;

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
   


    
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}



#pragma mark - Navigation

// Unwind segue from NewMeetingVC

- (IBAction)unwindFromNewMeetengsDetailVC:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMeetingsVC"]) {
        
        /* NewMeetingDetailViewController *controller = segue.sourceViewController;
         
         MeetingObject* newObject = controller.meetingObject;
         
         [self.myMeetingsDetailsData addObject:newObject];*/
        
        _disclaimerLabel.hidden = YES;
        
        //   [self.tableView reloadData];
        
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
        
    }else if ([segue.identifier isEqualToString:@"toNewMeetingDetailVC"]) {
        
        NewMeetingDetailViewController *nmdVC = (NewMeetingDetailViewController *)segue.destinationViewController;
        nmdVC.nameLabel.text = @"";
        nmdVC.priceLabel.text = @"";
        nmdVC.addressLabel.text = @"";
        nmdVC.chooseObjectString = @"Выберите объект";
        nmdVC.hideButton = YES;
   
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}


/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *dateRepresentingThisDay = [self.sortedDays objectAtIndex:section];
    return [self.sectionDateFormatter stringFromDate:dateRepresentingThisDay];
}*/



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MeetingCell";
    
    MeetingsCell *cell = (MeetingsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}


-(void)configureCell:(MeetingsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    MeetingObjectEntity* object = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"date"]];
    cell.dateLabel.textColor = [UIColor whiteColor];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"time"]];
    cell.timeLabel.textColor = [UIColor whiteColor];
    
    cell.objectNameLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"objectName"]];;
    cell.objectNameLabel.textColor = [UIColor whiteColor];
    
    cell.personNameLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"personName"]];;
    cell.personNameLabel.textColor = [UIColor whiteColor];
    
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
