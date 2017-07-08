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

@synthesize  myData, myPhotosData, fetchedResultsController, tableView;


#pragma mark - VC Lyficycle


- (void)viewDidLoad {
    
        
    [super viewDidLoad];
    
  
    
    self.emptyDataBaseLabel.hidden = YES;
    
    
    self.myData = [[NSMutableArray alloc] init];
    self.myPhotosData = [[NSMutableArray alloc] init];
    
    NSLog(@"all my photos in vdl = %@",myPhotosData);
   
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
   
}




#pragma mark - Unwind Segues


// unwind segue from NewObject VC
- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMain"]) {
        
       // NewObjectViewController *controller = segue.sourceViewController;
        
        //EstateObjectEntity* newObject = controller.myObject;
        
        _emptyDataBaseLabel.hidden = YES;
        
        
       // [self.myData addObject:newObject];
        
        NSLog(@"my aaaaray = %@",self.myData);
        NSLog(@"all my photos = %@",myPhotosData);
        
       // [self.tableView reloadData];
        
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



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DetailObjectController *controller = (DetailObjectController *)segue.destinationViewController;
        
        controller.myDetailObject = [self.myData objectAtIndex:indexPath.row];
        
        controller.myDetailPhotosArray = [[NSMutableArray alloc] init];
        
        controller.myDetailPhotosArray = self.myPhotosData;
        
    
    }
}



#pragma mark - Actions


- (IBAction)filterTapped:(UIButton *)sender {
    
    
}

- (IBAction)plusTapped:(UIButton *)sender {
    
    
}


-(IBAction)settingsTapped:(UIButton *)sender {
    
    
}




/*

#pragma mark - UITableViewDataSource


/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.myData count];
}

 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 50;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myData count] ;
}*/



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MainScreenCellTableViewCell *cell = (MainScreenCellTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
    
   /* EstateObject* object = [self.myData objectAtIndex:indexPath.row];
    
    cell.nameCellLabel.text = object.discription;
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    
    cell.priceCellLabel.text = object.price;
    cell.priceCellLabel.textColor = [UIColor whiteColor];
    
    cell.addressCellLabel.text = object.address;
    cell.addressCellLabel.textColor = [UIColor whiteColor];
    
    cell.ownerCellLabel.text = object.owner;
    cell.ownerCellLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    // cell.accessoryView.backgroundColor = [UIColor blueColor];
    
    cell.imageViewCell.image = object.picture;
   
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 374, 30)];
     
     view.backgroundColor = [UIColor clearColor];
     [cell.contentView addSubview:view];
    
    [self configureCell:cell atIndexPath:indexPath];

    
    return  cell;
  
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.myData removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    }
}*/




/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor clearColor];
    
   // [self.tableView addSubview:view];
    
    return view;
    
}*/





#pragma mark - UITableViewDelegate


/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  }*/







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
    NSSortDescriptor *discription = [[NSSortDescriptor alloc] initWithKey:@"discription" ascending:YES];
    NSSortDescriptor *price = [[NSSortDescriptor alloc] initWithKey:@"address" ascending:YES];
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
    
   
    /*NSArray *fecthedObject = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *photos in fecthedObject)
    
    {
        [self.myData addObject : [photos valueForKey :@"picture"]];
    }*/
    
    
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}


#pragma mark - Helper

- (void)configureCell:(MainScreenCellTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
       
    cell.nameCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"discription"]];
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    
    cell.priceCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"price"]];
    cell.priceCellLabel.textColor = [UIColor whiteColor];
    
    cell.addressCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"address"]];
    cell.addressCellLabel.textColor = [UIColor whiteColor];
    
    cell.ownerCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"owner"]];

    cell.ownerCellLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    // cell.accessoryView.backgroundColor = [UIColor blueColor];
    
  // NSData *data = [NSString stringWithFormat:@"%@",[object valueForKey:@"picture"]];
    
    // cell.imageViewCell.image = [UIImage imageWithData:data];
    
   
    
    /*NSString *imagePath = [NSHomeDirectory() stringByAppendingString : [[self.myData objectAtIndex:indexPath.row] stringByAppendingPathComponent:@"jpg"]];
   
    cell.imageViewCell.image = [UIImage imageNamed:imagePath];*/
       
    
   // cell.imageViewCell.image = [NSString stringWithFormat:@"%@",[object valueForKey:@"picture"]];
    
   /*UIImageView *categoryImageView = (UIImageView *)[cell viewWithTag:10];
    
    NSData *imageData = [NSString stringWithFormat:@"%@",[object valueForKey:@"picture"]];
    
    if (imageData == nil){
        categoryImageView.image = [UIImage imageNamed:@"emptyObject2"];
    }
    else{
        categoryImageView.image = [UIImage imageWithData:imageData];
    }*/
    
    
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 374, 30)];
    
    view.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:view];
    
   
}

@end
