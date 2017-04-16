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
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Unwind Segues

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)sender {
    
    if ([sender.identifier isEqualToString:@"toMain"]) {
        
        NewObjectViewController *controller = sender.sourceViewController;
        
        EstateObject* newObject = controller.myObject;
                
        [self.myData addObject:newObject];
        [self.tableView reloadData];
        
    
    }
    
    
}

- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)sender{
    

}


#pragma mark - Actions



- (IBAction)filterTapped:(UIButton *)sender {
    
    
}

- (IBAction)plusTapped:(UIButton *)sender {
   
    
}


-(IBAction)settingsTapped:(UIButton *)sender {
    
    
}



#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.myData count] ;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    static NSString* identifier = @"MainScreenCell";
    
    MainScreenCellTableViewCell *cell = (MainScreenCellTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
    
    EstateObject* object = [self.myData objectAtIndex:indexPath.row];
    
    cell.nameCellLabel.text = object.discription;
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    cell.priceCellLabel.text = object.price;
    cell.priceCellLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    // cell.accessoryView.backgroundColor = [UIColor blueColor];
    cell.imageViewCell.image = object.picture;
    
    return  cell;


}
    

    











@end
