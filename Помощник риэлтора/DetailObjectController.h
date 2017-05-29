//
//  DetailObjectController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 23.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomTypeController.h"
#import "NewObjectViewController.h"
#import "MainViewController.h"
#import "DetailCollectionViewCell.h"
#import "EstateObject.h"

@interface DetailObjectController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

{
    UIImageView *fullScreenImageView;
    UIImageView *originalImageView;
}



//@property (weak, nonatomic) IBOutlet DetailCollectionViewCell *collectionViewCell;




@property (weak, nonatomic) IBOutlet UIImageView *proxyView;




@property(strong, nonatomic) EstateObject* myObject;


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSMutableArray* myDetailPhotosArray;
@property(strong, nonatomic) NSMutableArray* myDetailData;




@property(strong, nonatomic) EstateObject* myDetailObject;


@property (weak, nonatomic) IBOutlet UIImageView *detailImageOfObject;
@property (weak, nonatomic) IBOutlet UILabel *detailPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *detailPinImage;

- (IBAction)detailMapAddressButton:(id)sender;
- (IBAction)callButton:(UIButton *)sender;

//- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender;
//- (IBAction)changeDetailItemBurButtonItem:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UILabel *detailRoomLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailWholeSquareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLivingSquareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailKitchenSquareLabel;


@property (weak, nonatomic) IBOutlet UILabel *detailOwnerLabel;



@property (weak, nonatomic) IBOutlet UIImageView *handsetImageView;





@end
