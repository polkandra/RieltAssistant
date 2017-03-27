//
//  StyleKitName.h
//  Realt assist
//
//  Created by Michael Kozlyukov on 27.03.17.
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

// iOS Controls Customization Outlets
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* gradient2Targets;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* gradient3Targets;

// Colors
+ (UIColor*)gradientColor;
+ (UIColor*)gradientColor2;
+ (UIColor*)gradientColor3;
+ (UIColor*)gradientColor4;
+ (UIColor*)gradientColor5;
+ (UIColor*)gradientColor6;

// Gradients
+ (CGGradientRef)linearGradient1;
+ (CGGradientRef)linearGradient;
+ (CGGradientRef)linearGradient2;

// Drawing Methods
+ (void)drawGradient1;
+ (void)drawGradient1WithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;
+ (void)drawGradient2;
+ (void)drawGradient2WithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;
+ (void)drawGradient3;
+ (void)drawGradient3WithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing;

// Generated Images
+ (UIImage*)imageOfGradient2;
+ (UIImage*)imageOfGradient3;

@end
