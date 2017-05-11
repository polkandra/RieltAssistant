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
    
    [self setNavigationController];
    
    self.emptyDataBaseLabel.hidden = NO;
    self.rubLabel.hidden = YES;
    
    self.myData = [[NSMutableArray alloc] init];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



-(void)setNavigationController {
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:143.0/255.0 blue:220.0/255.0 alpha:1.0]];
   
    //[self.navigationController.navigationBar setTranslucent:NO];
    
    //[self.navigationItem setTitle:@"Мои объекты"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
  
    /*[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];*/
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:19]}];
   
}




#pragma mark - Unwind Segues

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"toMain"]) {
        
        NewObjectViewController *controller = segue.sourceViewController;
        
        EstateObject* newObject = controller.myObject;
        
        _emptyDataBaseLabel.hidden = YES;
        _rubLabel.hidden = NO;
        
        [self.myData addObject:newObject];
        [self.tableView reloadData];
        
    }
}


- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue {
    
   
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
    
    return 150;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       
    MainScreenCellTableViewCell *cell = (MainScreenCellTableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:@"MainScreenCell" forIndexPath:indexPath];
    
    EstateObject* object = [self.myData objectAtIndex:indexPath.row];
    
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
    
    return  cell;


}
    
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //[self performSegueWithIdentifier:@"toRoomType" sender:self];
    
}










@end
