//
//  FilteredResultCellTableViewCell.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 20.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilteredResultCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *nameCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceCellLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerCellLabel;

@end
