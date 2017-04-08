//
//  UILabel+DynamicSize.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 02.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "UILabel+DynamicSize.h"

@implementation UILabel (DynamicSize)


- (CGFloat) resizeLabel:(UILabel *)theLabel shrinkViewIfLabelShrinks:(BOOL)canShrink {
    CGRect frame = [theLabel frame];
    CGSize size = [theLabel.text sizeWithFont:theLabel.font
                            constrainedToSize:CGSizeMake(frame.size.width, 9999)
                                lineBreakMode:UILineBreakModeWordWrap];
    CGFloat delta = size.height - frame.size.height;
    frame.size.height = size.height;
    [theLabel setFrame:frame];
    
    CGRect contentFrame = self.frame;
    contentFrame.size.height = contentFrame.size.height + delta;
    if(canShrink || delta > 0) {
        [self setFrame:contentFrame];
    }
    return delta;
}


- (CGFloat) resizeLabel:(UILabel *)theLabel {
    return [self resizeLabel:theLabel shrinkViewIfLabelShrinks:YES];
}


@end
