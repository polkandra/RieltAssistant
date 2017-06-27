//
//  StyleKitName.h
//  RieltAssist
//
//  Created by Michael Kozlyukov on 27.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

#import <UIKit/UIKit.h>



typedef enum : NSInteger
{
    StyleKitNameResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    StyleKitNameResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    StyleKitNameResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    StyleKitNameResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.

} StyleKitNameResizingBehavior;

extern CGRect StyleKitNameResizingBehaviorApply(StyleKitNameResizingBehavior behavior, CGRect rect, CGRect target);


@interface StyleKitName : NSObject

// Colors
+ (UIColor*)gradientColor;
+ (UIColor*)gradientColor2;
+ (UIColor*)textForeground;
+ (UIColor*)gradientColor7;
+ (UIColor*)gradientColor8;
+ (UIColor*)gradientColor46;
+ (UIColor*)gradientColor47;
+ (UIColor*)gradientColor52;
+ (UIColor*)gradientColor53;
+ (UIColor*)gradientColor54;
+ (UIColor*)gradientColor55;

// Gradients
+ (CGGradientRef)backgroundColorGradient;
+ (CGGradientRef)mainScreenTableViewGradient;
+ (CGGradientRef)gold;

// Drawing Methods
+ (void)drawBackgroundColor;
+ (void)drawBackgroundColorWithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;
+ (void)drawTableViewCell;
+ (void)drawTableViewCellWithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;
+ (void)drawSuperGradient;
+ (void)drawSuperGradientWithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;

@end