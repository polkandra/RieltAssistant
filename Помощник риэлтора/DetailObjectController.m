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


- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    
    
    [self setNavController];
   
    // self.myDetailPhotosArray = [[NSMutableArray alloc] init];
    
  //  self.myDetailData = [[NSMutableArray alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    
    
    if (self.detailItem) {
        
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
        //self.bigImage.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
    }
   
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
        
        NSLog(@"transfered pics == %@",self.myDetailPhotosArray);
    }





-(void)setNavController
{
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = @"Объект";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    navItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Изменить" style:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    navItem.rightBarButtonItem = rightButton;
    
    navbar.items = @[ navItem ];
    
    [self.view addSubview:navbar];
    
  
    
}

#pragma mark -- Helpers

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setEditing:(BOOL)editing
{
    
}



/*- (void) viewDidLayoutSubviews {
    CGFloat top = self.topLayoutGuide.length;
    CGFloat bottom = self.bottomLayoutGuide.length;
    UIEdgeInsets newInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.contentInset = newInsets;
    
}*/


- (IBAction)detailMapAddressButton:(id)sender {
    
    
}



- (IBAction)callButton:(UIButton *)sender {



}



#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toPage"]) {
        
        UIPageViewControllerScene *controller = (UIPageViewControllerScene *)segue.destinationViewController;
        
        controller.pageVCArray = [[NSMutableArray alloc]init];
        controller.pageVCArray = self.myDetailPhotosArray;
        
        
        
    }else if ([segue.identifier isEqualToString:@"backToNew"]) {
        
        NewObjectViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"New"];
        
        
        [self presentViewController:newVC animated:YES completion:nil];
    }
    
}







@end
