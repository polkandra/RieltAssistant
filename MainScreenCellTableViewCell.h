//
//  MainScreenCellTableViewCell.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 31.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleKitName.h"

@interface MainScreenCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *nameCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceCellLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerCellLabel;


@end
