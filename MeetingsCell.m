//
//  MeetingsCell.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MeetingsCell.h"

@implementation MeetingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeItCircle];
  //  self.personNameLabel.adjustsFontSizeToFitWidth = YES;

}



-(void)drawRect:(CGRect)rect {
    
    [StyleKitName gradientColor55];
    
}

-(void)makeItCircle {
    
    self.objectPicture.layer.masksToBounds = YES;
    // self.imageViewCell.layer.cornerRadius  = self.imageViewCell.frame.size.width/2.0;
    self.objectPicture.layer.cornerRadius  = 15;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
