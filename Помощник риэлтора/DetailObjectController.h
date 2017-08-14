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
#import "UIPageViewControllerScene.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"


@interface DetailObjectController : UITableViewController




@property(strong, nonatomic) NSMutableArray* fetchedArrayWithUsersPics;
@property(strong, nonatomic) NSMutableArray* sourceArray;



@property (strong, nonatomic) UIImageView *fullScreenImageView;
@property (strong, nonatomic) UIImageView *originalImageView;

//@property(strong, nonatomic) EstateObject* myObject;




//@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSMutableArray* myDetailPhotosArray;
@property(strong, nonatomic) NSMutableArray* fetchedObjects;


@property(strong, nonatomic) EstateObjectEntity* detailItem;





@property (weak, nonatomic) IBOutlet UILabel *detailPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *detailPinImage;

- (IBAction)detailMapAddressButton:(id)sender;
- (IBAction)callButton:(UIButton *)sender;

//- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender;
//- (IBAction)changeDetailItemBurButtonItem:(UIBarButtonItem *)sender;


@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRoomLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailWholeSquareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLivingSquareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailKitchenSquareLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailOwnerLabel;



@property (weak, nonatomic) IBOutlet UIImageView *handsetImageView;





@end
