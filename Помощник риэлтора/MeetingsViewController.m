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
   


    self.myMeetingsDetailsData = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


   
}

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



#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetailMeetingVC"]) {
        
        DetailMeetingController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MeetingObjectEntity *selectedEntity = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        controller.myMeetingObject = selectedEntity;
        // controller.detailItem = self.detailItem;
        
        
        //        EstateObjectEntity *selectedEntity1 = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //        controller.detailItem = selectedEntity1;
        //
//        NSError *error;
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
//        self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
//        
//        for (id object in self.retrievedArray) {
//            if ([object isKindOfClass:[EstateObjectEntity class]]) {
//                self.detailItem = ((EstateObjectEntity *)object);
//            }
//        }
//         self.detailItem = controller.detailItem;
        
        
        //        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //
        //
        
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
    
  
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:10];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *discription = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSSortDescriptor *price = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    
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
