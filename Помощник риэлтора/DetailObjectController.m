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
    
    
   // self.myDetailPhotosArray = [[NSMutableArray alloc] init];
    
  //  self.myDetailData = [[NSMutableArray alloc] init];
    
    
      
  /*  if (self.detailItem) {
    
    self.detailPriceLabel.text = detailItem.price;
    self.detailAddressLabel.text = detailItem.address;
    self.detailOwnerLabel.text = detailItem.owner;
    self.detailRoomLabel.text = detailItem.roomQuantity;
    self.detailWholeSquareLabel.text = detailItem.wholeArea;
    self.detailLivingSquareLabel.text = detailItem.livingArea;
    self.detailKitchenSquareLabel.text = detailItem.kitchenArea;
    self.phoneNumberLabel.text = detailItem.phoneNumber;
    self.actionLabel.text = detailItem.actionByProperty;
    self.typeLabel.text = detailItem.typeOfProperty;
    
    }*/
    
    
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
   


    /* self.detailPriceLabel.text = myDetailObject.price;
    self.detailAddressLabel.text = myDetailObject.address;
    self.detailOwnerLabel.text = myDetailObject.owner;
    self.detailRoomLabel.text = myDetailObject.roomQuantity;
    self.detailWholeSquareLabel.text = myDetailObject.wholeArea;
    self.detailLivingSquareLabel.text = myDetailObject.livingArea;
    self.detailKitchenSquareLabel.text = myDetailObject.kitchenArea;
    self.phoneNumberLabel.text = myDetailObject.phoneNumber;
    self.actionLabel.text = myDetailObject.typeOfProperty;
    self.typeLabel.text = myDetailObject.actionByProperty;*/
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
        
        NSLog(@"transfered pics == %@",self.myDetailPhotosArray);
    }






- (IBAction)detailMapAddressButton:(id)sender {
    
    
}



- (IBAction)callButton:(UIButton *)sender {






}



/*- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender {
    

}

- (IBAction)changeDetailItemBurButtonItem:(UIBarButtonItem *)sender {
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [self.myDetailPhotosArray count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"detailCollectionViewCell";
    
    DetailCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    if ([self.myDetailPhotosArray containsObject:@"emptyObject2"]) {
        cell.detailImageView.image = nil;
        
    }else{
        
        cell.detailImageView.image = [self.myDetailPhotosArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
    
}*/

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
