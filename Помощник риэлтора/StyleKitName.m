//
//  StyleKitName.m
//  RieltAssist
//
//  Created by Michael Kozlyukov on 16.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//




#import "StyleKitName.h"


@implementation StyleKitName

#pragma mark Cache

static UIColor* _gradientColor = nil;
static UIColor* _gradientColor2 = nil;
static UIColor* _textForeground = nil;
static UIColor* _gradientColor7 = nil;
static UIColor* _gradientColor8 = nil;
static UIColor* _gradientColor46 = nil;
static UIColor* _gradientColor47 = nil;
static UIColor* _gradientColor52 = nil;
static UIColor* _gradientColor53 = nil;

static CGGradientRef _backgroundColorGradient = NULL;
static CGGradientRef _mainScreenTableViewGradient = NULL;

#pragma mark Initialization

+ (void)initialize
{
    // Colors Initialization
    _gradientColor = [UIColor colorWithRed: 0 green: 0.918 blue: 0.973 alpha: 1];
    _gradientColor2 = [UIColor colorWithRed: 0.427 green: 0.259 blue: 0.937 alpha: 1];
    _textForeground = [UIColor colorWithRed: 0.169 green: 0.827 blue: 0.859 alpha: 1];
    _gradientColor7 = [UIColor colorWithRed: 0.227 green: 0.482 blue: 0.835 alpha: 1];
    _gradientColor8 = [UIColor colorWithRed: 0 green: 0.824 blue: 1 alpha: 1];
    _gradientColor46 = [UIColor colorWithRed: 0.675 green: 0.573 blue: 0.925 alpha: 1];
    _gradientColor47 = [UIColor colorWithRed: 0.455 green: 0.333 blue: 0.765 alpha: 1];
    _gradientColor52 = [UIColor colorWithRed: 0.282 green: 0.812 blue: 0.678 alpha: 1];
    _gradientColor53 = [UIColor colorWithRed: 0.098 green: 0.655 blue: 0.518 alpha: 1];

    // Gradients Initialization
    CGFloat backgroundColorGradientLocations[] = {0, 1};
    _backgroundColorGradient = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)StyleKitName.gradientColor.CGColor, (id)StyleKitName.gradientColor2.CGColor], backgroundColorGradientLocations);
    CGFloat mainScreenTableViewGradientLocations[] = {0, 1};
    _mainScreenTableViewGradient = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)StyleKitName.gradientColor52.CGColor, (id)StyleKitName.gradientColor53.CGColor], mainScreenTableViewGradientLocations);

}

#pragma mark Colors

+ (UIColor*)gradientColor { return _gradientColor; }
+ (UIColor*)gradientColor2 { return _gradientColor2; }
+ (UIColor*)textForeground { return _textForeground; }
+ (UIColor*)gradientColor7 { return _gradientColor7; }
+ (UIColor*)gradientColor8 { return _gradientColor8; }
+ (UIColor*)gradientColor46 { return _gradientColor46; }
+ (UIColor*)gradientColor47 { return _gradientColor47; }
+ (UIColor*)gradientColor52 { return _gradientColor52; }
+ (UIColor*)gradientColor53 { return _gradientColor53; }

#pragma mark Gradients

+ (CGGradientRef)backgroundColorGradient { return _backgroundColorGradient; }
+ (CGGradientRef)mainScreenTableViewGradient { return _mainScreenTableViewGradient; }

#pragma mark Drawing Methods

+ (void)drawBackgroundColor
{
    [StyleKitName drawBackgroundColorWithFrame: CGRectMake(0, 0, 375, 667) resizing: StyleKitNameResizingBehaviorStretch];
}

+ (void)drawBackgroundColorWithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitNameResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);



    //// Gradient Declarations
    CGFloat linearGradient5Locations[] = {0, 1};
    CGGradientRef linearGradient5 = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)StyleKitName.gradientColor7.CGColor, (id)StyleKitName.gradientColor8.CGColor], linearGradient5Locations);

    //// MainScreenBackgroundColor Drawing
    UIBezierPath* mainScreenBackgroundColorPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 375, 667)];
    CGContextSaveGState(context);
    [mainScreenBackgroundColorPath addClip];
    CGContextDrawLinearGradient(context, linearGradient5, CGPointMake(187.5, -0), CGPointMake(187.5, 667), kNilOptions);
    CGContextRestoreGState(context);


    //// Cleanup
    CGGradientRelease(linearGradient5);
    
    CGContextRestoreGState(context);

}

+ (void)drawTableViewCell
{
    [StyleKitName drawTableViewCellWithFrame: CGRectMake(0, 0, 375, 100) resizing: StyleKitNameResizingBehaviorStretch];
}

+ (void)drawTableViewCellWithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitNameResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 100), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 100);


    //// cell Drawing
    UIBezierPath* cellPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 375, 100) cornerRadius: 20];
    CGContextSaveGState(context);
    [cellPath addClip];
    CGContextDrawLinearGradient(context, StyleKitName.mainScreenTableViewGradient, CGPointMake(187.5, -0), CGPointMake(187.5, 100), kNilOptions);
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);

}

@end



CGRect StyleKitNameResizingBehaviorApply(StyleKitNameResizingBehavior behavior, CGRect rect, CGRect target)
{
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero))
        return rect;

    CGSize scales = CGSizeZero;
    scales.width = ABS(target.size.width / rect.size.width);
    scales.height = ABS(target.size.height / rect.size.height);

    switch (behavior)
    {
        case StyleKitNameResizingBehaviorAspectFit:
        {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case StyleKitNameResizingBehaviorAspectFill:
        {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case StyleKitNameResizingBehaviorStretch:
            break;
        case StyleKitNameResizingBehaviorCenter:
        {
            scales.width = 1;
            scales.height = 1;
            break;
        }
    }

    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = target.origin.x + (target.size.width - result.size.width) / 2;
    result.origin.y = target.origin.y + (target.size.height - result.size.height) / 2;
    return result;
}
