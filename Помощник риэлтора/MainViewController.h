//
//  FirstViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainScreenCellTableViewCell.h"
#import "StyleKitName.h"
#import "NewObjectViewController.h"
#import "EstateObject.h"


@interface MainViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>

/*
@property(weak, nonatomic)  NSString* myTextObjectName;
@property(weak, nonatomic)  NSString* myTextObjectPrice;
@property(weak, nonatomic)  UIImageView* myObjectPicture;*/




@property(strong, nonatomic) NSMutableArray* myData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *nameOfObjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOfObjectLabel;*/



- (IBAction)filterTapped:(UIButton *)sender;
- (IBAction)plusTapped:(UIButton *)sender;
- (IBAction)settingsTapped:(UIButton *)sender;

- (IBAction)saveButtonTaped:(UIStoryboardSegue*)segue;
- (IBAction)cancelButtonTapped:(UIStoryboardSegue *)segue;

@end

