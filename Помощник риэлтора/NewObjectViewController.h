//
//  NewObjectViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "MainScreenCellTableViewCell.h"
#import "EstateObject.h"
#import "CollectionViewCell.h"
#import "StyleKitName.h"
#import "RoomTypeController.h"
#import "AddToMapVC.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "MapViewController.h"

@interface NewObjectViewController : UITableViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, NSKeyedArchiverDelegate>


@property (assign, nonatomic) int itemCount;

@property (weak, nonatomic) IBOutlet UILabel *objectTypeLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *actionTypeLabelInCell;


@property (nonatomic, assign) BOOL hideButton;

@property (weak, nonatomic) IBOutlet UIButton *saveSecondButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteSecondButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelSecondButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveRightBarButton;

@property (strong, nonatomic) EstateObjectEntity* detailItemFromDetailObjectVC;
@property (strong, nonatomic) EstateObjectEntity* detailItem;



@property(strong, nonatomic) NSMutableArray* pickerViewArrayCity;
@property(strong, nonatomic) NSMutableArray* pickerViewArrayRoomQuantity;

@property(strong, nonatomic) NSMutableArray *myArrayWithPhotoData;
@property(strong, nonatomic) NSMutableArray* myPhotosArray;
@property(strong, nonatomic) NSMutableArray* selectedPhotos;
@property(strong, nonatomic) NSMutableArray* fetchedPhotos;
@property(strong, nonatomic) NSMutableArray* myRetrievedPics;
@property(strong, nonatomic) NSMutableArray* myData1;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSIndexPath *expandedIndexPath;


@property(nonatomic, assign) id<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>delegate;



- (IBAction)unwindToNewObjectVCAfterSaveButtonTaped:(UIStoryboardSegue*)segue;
- (IBAction)unwindToNewObjectVCAfterBackButtonTapped:(UIStoryboardSegue *)segue;


@property (weak, nonatomic) IBOutlet UIButton *addPlaceOnMapButton;
- (IBAction)addPlaceToMapButton:(UIButton *)sender;
- (IBAction)addPhotosButton:(UIButton *)sender;
- (IBAction)deletePhotosButton:(UIButton *)sender;




@property (weak, nonatomic) IBOutlet UILabel *objectTypeLabel;


@property (weak, nonatomic) IBOutlet UITextField *objectNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *objectNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *adressTextfield;


@property (weak, nonatomic) IBOutlet UILabel *roomAddonLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalSquareLabel;

@property (weak, nonatomic) IBOutlet UITextField *totalSquareTextField;


@property (weak, nonatomic) IBOutlet UILabel *livingSquareLabel;
@property (weak, nonatomic) IBOutlet UITextField *livingSquareTextField;



@property (weak, nonatomic) IBOutlet UITextField *kitchenSquareTextField;
@property (weak, nonatomic) IBOutlet UILabel *kitchenMetersLabel;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;


@property (weak, nonatomic) IBOutlet UILabel *metroFloorLabel;
@property (weak, nonatomic) IBOutlet UITextField *metroFloorTextField;


@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ownerNameTextField;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;


@property (weak, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *extraInfoTextField;


@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *roomPicker;


@end
