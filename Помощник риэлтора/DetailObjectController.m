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
@synthesize tableView, collectionView, myPhotosArray, myDetailData, myDetailObject;




- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.myDetailData = [[NSMutableArray alloc] init];
    
    self.detailPriceLabel.text = myDetailObject.price;
    self.detailImageOfObject.image = myDetailObject.picture;
    self.detailAddressLabel.text = myDetailObject.address;
    self.detailOwnerLabel.text = myDetailObject.owner;
    self.detailRoomLabel.text = myDetailObject.roomQuantity;
    self.detailWholeSquareLabel.text = myDetailObject.wholeArea;
    self.detailLivingSquareLabel.text = myDetailObject.livingArea;
    self.detailKitchenSquareLabel.text = myDetailObject.kitchenArea;

    NSLog(@"transfered pics ==%@",myPhotosArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)detailMapAddressButton:(id)sender {


}



- (IBAction)callButton:(UIButton *)sender {
}

/*- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender {
    

}

- (IBAction)changeDetailItemBurButtonItem:(UIBarButtonItem *)sender {
}*/



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [myPhotosArray count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"detailCollectionViewCell";
    
    DetailCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.detailImageView.image = [myPhotosArray objectAtIndex:indexPath.row];
    
    return cell;
    

}














@end
