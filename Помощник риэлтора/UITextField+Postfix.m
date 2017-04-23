//
//  UITextField+Postfix.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 23.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "UITextField+Postfix.h"

@implementation UITextField (Postfix)

- (void)setSuffixText:(NSString *)suffix
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:self.font.fontName size:self.font.pointSize]];
    [label setTextColor:self.textColor];
    [label setAlpha:.5];
    [label setText:suffix];
    
    CGSize suffixSize = [suffix sizeWithFont:label.font];
    label.frame = CGRectMake(0, 0, suffixSize.width, self.frame.size.height);
    
    [self setRightView:label];
    [self setRightViewMode:UITextFieldViewModeAlways];
    
}



@end
