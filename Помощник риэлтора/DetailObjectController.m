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
@synthesize tableView,  myDetailPhotosArray, myDetailData, myDetailObject;




- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    
    //self.myDetailPhotosArray = [[NSMutableArray alloc] init];
    
    self.myDetailData = [[NSMutableArray alloc] init];
    
    self.detailPriceLabel.text = myDetailObject.price;
    self.detailAddressLabel.text = myDetailObject.address;
    self.detailOwnerLabel.text = myDetailObject.owner;
    self.detailRoomLabel.text = myDetailObject.roomQuantity;
    self.detailWholeSquareLabel.text = myDetailObject.wholeArea;
    self.detailLivingSquareLabel.text = myDetailObject.livingArea;
    self.detailKitchenSquareLabel.text = myDetailObject.kitchenArea;
    self.phoneNumberLabel.text = myDetailObject.phoneNumber;
    self.actionLabel.text = myDetailObject.typeOfProperty;
    self.typeLabel.text = myDetailObject.actionByProperty;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
    
    NSLog(@"transfered pics == %@",self.myDetailPhotosArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //UITouch *touch = [touches anyObject];
    //CGPoint pointInCollectionView = [touch locationInView:self.collectionView];
    //NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:pointInCollectionView];
    //UICollectionViewCell *selectedCell = [self.collectionView cellForItemAtIndexPath:selectedIndexPath];
   
    DetailCollectionViewCell *cell = (DetailCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    originalImageView = cell.detailImageView;
    
    fullScreenImageView = [[UIImageView alloc] init];
    [fullScreenImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    fullScreenImageView.image = [originalImageView image];
    
    
    
    CGRect tempPoint = CGRectMake(originalImageView.center.x, originalImageView.center.y, 0, 0);
    
    // OR, if you want to zoom from the tapped point...
    //CGRect tempPoint = CGRectMake(pointInCollectionView.x, pointInCollectionView.y, 0, 0);
    
    //CGRect startingPoint = [self.view convertRect:tempPoint fromView:[self.collectionView cellForItemAtIndexPath:selectedIndexPath]];
   // [fullScreenImageView setFrame:startingPoint];
    
    [fullScreenImageView setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.9f]];
    
    [self.view addSubview:fullScreenImageView];
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         [fullScreenImageView setFrame:CGRectMake(0,
                                                                  0,
                                                                  self.view.bounds.size.width,
                                                                  self.view.bounds.size.height)];
                     }];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullScreenImageViewTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [fullScreenImageView addGestureRecognizer:singleTap];
    [fullScreenImageView setUserInteractionEnabled:YES];
    
    
}

- (void)fullScreenImageViewTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    CGRect point = [self.view convertRect:originalImageView.bounds fromView:originalImageView];
    
    gestureRecognizer.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [(UIImageView *)gestureRecognizer.view setFrame:point];
                     }];
    [self performSelector:@selector(animationDone:) withObject:[gestureRecognizer view] afterDelay:0.4];
    
}


-(void)animationDone:(UIView  *)view
{
    [fullScreenImageView removeFromSuperview];
    fullScreenImageView = nil;
}

*/






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
