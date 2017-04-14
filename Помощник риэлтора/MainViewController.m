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

@synthesize  myData;



#pragma mark - VC Lyficycle




- (void)viewDidLoad {
    
  
    /*
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* myData = [defaults objectForKey:@"myData"];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* objectName = [defaults objectForKey:@"objectName"];
    NSString* objectPrice = [defaults objectForKey:@"objectPrice"];
    nameOfObjectLabel = objectName;
    priceOfObjectLabel = objectPrice; */
    
    
    [super viewDidLoad];
    
       //set bar color
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:143.0/255.0 blue:220.0/255.0 alpha:1.0]];
    //optional, i don't want my bar to be translucent
    [self.navigationController.navigationBar setTranslucent:YES];
    //set title and title color
    [self.navigationItem setTitle:@"Мои объекты"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //set back button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:21]}];

    
    self.myData = [[NSMutableArray alloc] init];
                   
                   //self.tableView.backgroundColor = [UIColor clearColor];
    
   
}

#pragma mark - Unwind Segues

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)sender {
    
    if ([sender.identifier isEqualToString:@"toMain"]) {
        
        NewObjectViewController *controller = sender.sourceViewController;
        
        EstateObject* newObject = controller.myObject;
        
        //NSString* discription = controller.objectNameTextField;
        // NSString* price = controller.priceTextField;
        
        [self.myData addObject:newObject];
        [self.tableView reloadData];
        
        
        
        /*
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.myData count] - 1) inSection:1];
        
        // Insert it into the tableview
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];*/

        /*NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:objectName forKey:@"objectName"];
         [defaults setObject:objectPrice forKey:@"objectPrice"];
         [defaults synchronize];
         NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:myData forKey:@"myData"];
         [defaults synchronize];*/
        
    }


}

- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue{
    
}


#pragma mark - Actions



- (IBAction)filterTapped:(UIButton *)sender {


}

- (IBAction)plusTapped:(UIButton *)sender {

   /* NewObjectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewObjectViewController"];
    [self.navigationController pushViewController:controller animated:YES];*/


}


-(IBAction)settingsTapped:(UIButton *)sender {


}



#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myData count] ;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"MainScreenCell";
    
      
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //MainScreenCellTableViewCell *cell = (MainScreenCellTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
    
    EstateObject* object = [self.myData objectAtIndex:indexPath.row];
    cell.textLabel.text = object.discription;
    cell.detailTextLabel.text = object.price;
    
    
    //cell.nameCellLabel.text =[self.myData objectAtIndex:indexPath.row];
    // cell.priceCellLabel.text = [self.myData objectAtIndex:indexPath.row];
    
    // cell = [[EstateObject alloc] initWithDiscription:newObject.discription price:newObject.price picture:newObject.picture];
    
    /*cell.nameCellLabel.adjustsFontSizeToFitWidth = YES;
     cell.nameCellLabel.minimumScaleFactor = 10 / 14;
     cell.priceCellLabel.adjustsFontSizeToFitWidth = YES;
     cell.priceCellLabel.minimumScaleFactor = 10 / 14;*/
    
    
      
     
   
    
    return cell;
    
    
    }
  









@end
