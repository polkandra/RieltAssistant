//
//  MainScreenCellTableViewCell.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 31.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MainScreenCellTableViewCell.h"

@implementation MainScreenCellTableViewCell
@synthesize nameCellLabel, priceCellLabel, imageViewCell;


-(void)drawRect:(CGRect)rect {
    
    [StyleKitName drawTableViewCell];
}


/*

 - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
 
 
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
 {
  imageViewCell = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, 99, 79))];
 
  nameCellLabel = [[UILabel alloc] initWithFrame:(CGRectMake(107, 8, 173, 42))];
  nameCellLabel = [UIFont systemFontOfSize:17];
  nameCellLabel.textAlignment = NSTextAlignmentCenter;
 
 priceCellLabel = [[UILabel alloc] initWithFrame:(CGRectMake(137, 49, 113, 21))];
 priceCellLabel.font = [UIFont systemFontOfSize:13];
 priceCellLabel.textAlignment = NSTextAlignmentCenter;
 
 [self.contentView addSubview:nameCellLabel];
 [self.contentView addSubview:priceCellLabel];
 [self.contentView addSubview:priceCellLabel];
 }
 
 return self;
}
*/


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
