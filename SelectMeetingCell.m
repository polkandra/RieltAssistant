//
//  SelectMeetingCell.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SelectMeetingCell.h"

@implementation SelectMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self makeItCircle];
}


-(void)makeItCircle {
    
    self.meetingPicture.layer.masksToBounds = YES;
    self.meetingPicture.layer.cornerRadius  = self.meetingPicture.frame.size.width/2.0;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
