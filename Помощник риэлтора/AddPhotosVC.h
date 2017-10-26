//
//  AddPhotosVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstateObject.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"
#import "AddPhotoCVCell.h"
#import "StyleKitName.h"
#import "NewObjectViewController.h"

@interface AddPhotosVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, nonatomic) NSMutableArray *myRetrievedPics;
@property(strong, nonatomic) NSMutableArray *myPhotosArray;

@property (strong, nonatomic) EstateObjectEntity *detailItem;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong, nonatomic) NSMutableArray *myArrayWithPhotoData;
@property(strong, nonatomic) NSMutableArray *arrayWithEntities;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)addPics:(UIButton *)sender;
- (IBAction)deletePics:(UIButton *)sender;

@end
