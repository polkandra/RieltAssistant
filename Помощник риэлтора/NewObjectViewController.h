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


@interface NewObjectViewController : UITableViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@property (weak, nonatomic) IBOutlet UILabel *objectTypeLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *actionTypeLabelInCell;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveRightBarButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property(strong, nonatomic) EstateObject* myObject;


@property(strong, nonatomic) NSMutableArray* myPhotosArray;
@property(strong, nonatomic) NSMutableArray* selectedPhotos;

@property(strong, nonatomic) NSMutableArray* pickerViewArrayCity;
@property(strong, nonatomic) NSMutableArray* pickerViewArrayRoomQuantity;

@property(strong, nonatomic) NSMutableArray* myData;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property(nonatomic, assign) id<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>delegate;




- (IBAction)unwindToNewObjectVCAfterSaveButtonTaped:(UIStoryboardSegue*)segue;
- (IBAction)unwindToNewObjectVCAfterBackButtonTapped:(UIStoryboardSegue *)segue;



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
