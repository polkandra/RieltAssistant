//
//  NewObjectViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewObjectViewController : UITableViewController

- (IBAction)saveAction:(UIBarButtonItem *)sender;

- (IBAction)addPlaceToMapButton:(UIButton *)sender;
- (IBAction)addPhotosButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *adressTextfield;


@property (weak, nonatomic) IBOutlet UILabel *roomAddonLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalSquareLabel;

@property (weak, nonatomic) IBOutlet UITextField *totalSquareTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalSquareMetersLabel;

@property (weak, nonatomic) IBOutlet UILabel *livingSquareLabel;
@property (weak, nonatomic) IBOutlet UITextField *livingSquareTextField;
@property (weak, nonatomic) IBOutlet UILabel *livingSquareMetersLabel;

@property (weak, nonatomic) IBOutlet UILabel *kitchenSquareLabel;
@property (weak, nonatomic) IBOutlet UITextField *kitchenSquareTextField;
@property (weak, nonatomic) IBOutlet UILabel *kitchenMetersLabel;


@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceRoublesLabel;

@property (weak, nonatomic) IBOutlet UILabel *metroFloorLabel;
@property (weak, nonatomic) IBOutlet UITextField *metroFloorTextField;


@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ownerNameTextField;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;


@property (weak, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *extraInfoTextField;



@end
