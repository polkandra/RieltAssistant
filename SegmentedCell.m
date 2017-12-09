//
//  SegmentedCell.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.12.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SegmentedCell.h"

@implementation SegmentedCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
