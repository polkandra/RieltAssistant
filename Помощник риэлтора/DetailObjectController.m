//
//  DetailObjectController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 23.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "DetailObjectController.h"

@interface DetailObjectController ()

@end

@implementation DetailObjectController
@synthesize tableView,  myDetailPhotosArray, detailItem;


#pragma mark - VC Lifecycle


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self configureView];
    
    
    //[self setNavController];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    /*NSError *error;
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
     self.fetchedObjects = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];*/
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.sourceArray = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
}



#pragma mark - Helpers

-(void)configureView {
    
    if (self.detailItem) {
        
        self.title = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
       
        self.detailPriceLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"price"]];
        self.detailAddressLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"address"]];
        self.detailOwnerLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"owner"]];
        self.detailRoomLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"roomQuantity"]];
        self.detailWholeSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"wholeArea"]];
        self.detailLivingSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"livingArea"]];
        self.detailKitchenSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"kitchenArea"]];
        self.phoneNumberLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"phoneNumber"]];
        self.actionLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"typeOfProperty"]];
        self.typeLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"actionByProperty"]];
       
    }
}


/*-(void)setNavController
{
    
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
    
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonSystemItemDone target:self action:@selector(cancel:)];
    navItem.leftBarButtonItem = leftButton;
    
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Изменить" style:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    navItem.rightBarButtonItem = rightButton;
    navbar.
   
    // navbar.items = @[ navItem ];
       // [self.view addSubview:navbar];
}*/






#pragma mark - Segues




// unwind segue from AddToMapVC with saving
- (IBAction)saveFromAddToMapVC:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"saveFromAddToMapVC:"]) {
      
    
    }
    
}



// unwind segue from NewObjectVC with saving
- (IBAction)saveSecondButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"unwindAndSaveToDetail"]) {
        
        NSMutableArray *arrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
        self.sourceArray = [[NSMutableArray alloc] initWithArray:arrayWithUsersPics];
    
       
        [self configureView];
        
        
    }
    
}


// unwind segue from NewObjectVC with canceling
- (IBAction)cancelFromNewObjectButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"cancelFromNewObjectButtonTaped"]) {
              
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toPage"]) {
        
        UIPageViewControllerScene *controller = (UIPageViewControllerScene *)segue.destinationViewController;
        controller.detailItem = self.detailItem;
        
                    
    }else if ([segue.identifier isEqualToString:@"editFromDetailVC"]) {
                
        NewObjectViewController *newVC = (NewObjectViewController *)segue.destinationViewController;
        newVC.detailItem = self.detailItem;
        newVC.navigationItem.title = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
        newVC.navigationItem.rightBarButtonItem = nil;
        newVC.navigationItem.leftBarButtonItem = nil;
        newVC.saveSecondButton.hidden = NO;
        newVC.hideButton = NO;
        newVC.navigationItem.hidesBackButton = YES;
   
        
    }else if ([segue.identifier isEqualToString:@"unwindAfterBackButtonFromDetail"]) {
        
       // MainViewController*newVC = (NewObjectViewController *)segue.destinationViewController;
        
        NSData* pictureData = UIImageJPEGRepresentation([self.sourceArray firstObject],0);
        detailItem.picture = pictureData;
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
    
    } else if ([segue.identifier isEqualToString:@"toMapView"]) {
        
        AddToMapVC *mapVC = (AddToMapVC *)segue.destinationViewController;
        mapVC.detailItem = self.detailItem;
                
        mapVC.pinPhotosArray = self.sourceArray;
    }
   
}



#pragma mark - Actions


- (IBAction)addPlaceToMapButton:(UIButton *)sender {
    
   // AddToMapVC *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddToMapVC"];
   // mapVC.detailItem = self.detailItem;
    
  
    
}



- (IBAction)callButton:(UIButton *)sender {
    
    
}



@end
