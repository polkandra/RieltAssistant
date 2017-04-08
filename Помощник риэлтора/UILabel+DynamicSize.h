//
//  UILabel+DynamicSize.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 02.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DynamicSize)

- (CGFloat) resizeLabel:(UILabel *)theLabel;

- (CGFloat) resizeLabel:(UILabel *)theLabel shrinkViewIfLabelShrinks:(BOOL)canShrink;


@end
