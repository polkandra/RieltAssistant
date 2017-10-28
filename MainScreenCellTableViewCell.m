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
    
    //[StyleKitName drawVeryNewCell];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self makeItCircle];
}


-(void)makeItCircle {
    
    self.imageViewCell.layer.masksToBounds = YES;
   // self.imageViewCell.layer.cornerRadius  = self.imageViewCell.frame.size.width/2.0;
    self.imageViewCell.layer.cornerRadius  = 15;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}






@end
