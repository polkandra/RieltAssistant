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

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue {
    
    
    NewObjectViewController *controller = segue.sourceViewController;
    EstateObject* newObject = [[EstateObject alloc] initWithDiscription:controller.myTextObjectName price:controller.myTextObjectPrice picture:controller.myObjectPicture];
    if(newObject != nil) {
    
    [self.myData addObject:newObject];
    [self.tableView reloadData];
}
    
    /*NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objectName forKey:@"objectName"];
    [defaults setObject:objectPrice forKey:@"objectPrice"];
    [defaults synchronize];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myData forKey:@"myData"];
    [defaults synchronize];*/
    
     


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
    
    EstateObject* newObject = [self.myData objectAtIndex:indexPath.row];
    
    
    
    MainScreenCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
       
    cell = [[EstateObject alloc] initWithDiscription:newObject.discription price:newObject.price picture:newObject.picture];
    
    /*cell.nameCellLabel.adjustsFontSizeToFitWidth = YES;
    cell.nameCellLabel.minimumScaleFactor = 10 / 14;
    cell.priceCellLabel.adjustsFontSizeToFitWidth = YES;
    cell.priceCellLabel.minimumScaleFactor = 10 / 14;*/

    
      
    
    /*cell.nameCellLabel.numberOfLines = 1;
    cell.nameCellLabel.minimumScaleFactor = 8.;
    cell.nameCellLabel.adjustsFontSizeToFitWidth = YES;*/
   
    
    
    
    cell.imageViewCell.image = newObject.picture;
    cell.nameCellLabel.text = newObject.discription;
    cell.priceCellLabel.text = newObject.price;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
   
    
    
    
    
    // cell.nameCellLabel.font = [UIFont systemFontOfSize:20];
      
    
   
    
    return cell;
    
    // MainScreenCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
   
   // cell = [[EstateObject alloc]initWithDiscription:newObject.discription price:newObject.price];
    
    /* UILabel* labelName = (UILabel*)[cell viewWithTag:100];
     UILabel* labelPrice = (UILabel*)[cell viewWithTag:101];
    labelName = newObject.discription;
    labelPrice = newObject.price;*/
   
    
    /* MainScreenCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];*/
    
   /*
    cell.nameOfObjectCell = [self.myData objectAtIndex:indexPath.row];
    cell.priceOfObjectCell = [self.myData objectAtIndex:indexPath.row];*/
    
    // cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[self.myData objectAtIndex:0],[self.myData objectAtIndex:1]];
    
    
    
    /* UILabel* labelName = (UILabel*)[cell viewWithTag:100];
        UILabel* labelPrice = (UILabel*)[cell viewWithTag:101];
        labelName.text = [self.myData objectAtIndex:indexPath.row];*/
   
    
    /*
    UILabel* labelName = (UILabel*)[cell viewWithTag:100];
    UILabel* labelAddress = (UILabel*)[cell viewWithTag:101];
    UILabel* labelPrice = (UILabel*)[cell viewWithTag:101];
    labelName.text = [self.myData objectAtIndex:indexPath.row];
    labelAddress.text = [self.myData objectAtIndex:indexPath.row];
    labelPrice.text = [self.myData objectAtIndex:indexPath.row]; */
  
    
    }
  









@end
