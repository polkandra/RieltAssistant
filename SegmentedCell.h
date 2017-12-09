//
//  SegmentedCell.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.12.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *nameCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceCellLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerCellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeView;
@property (weak, nonatomic) IBOutlet UIImageView *statusView;

@end
