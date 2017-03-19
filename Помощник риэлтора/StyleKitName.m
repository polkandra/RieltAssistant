//
//  StyleKitName.m
//  Помощник риэлтора
//
//  Created by Michael Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

#import "StyleKitName.h"


@implementation StyleKitName

#pragma mark Cache

static UIColor* _gradientColor = nil;
static UIColor* _gradientColor2 = nil;
static UIColor* _gradientColor5 = nil;
static UIColor* _gradientColor6 = nil;
static UIColor* _color = nil;
static UIColor* _textForeground = nil;

static CGGradientRef _backgroundColor = NULL;
static CGGradientRef _tabBar = NULL;

#pragma mark Initialization

+ (void)initialize
{
    // Colors Initialization
    _gradientColor = [UIColor colorWithRed: 0 green: 0.918 blue: 0.973 alpha: 1];
    _gradientColor2 = [UIColor colorWithRed: 0.427 green: 0.259 blue: 0.937 alpha: 1];
    _gradientColor5 = [UIColor colorWithRed: 0.78 green: 0.906 blue: 0.922 alpha: 0.299];
    _gradientColor6 = [UIColor colorWithRed: 0.624 green: 0.984 blue: 0.961 alpha: 0.5];
    _color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    _textForeground = [UIColor colorWithRed: 0.169 green: 0.827 blue: 0.859 alpha: 1];

    // Gradients Initialization
    CGFloat backgroundColorLocations[] = {0, 1};
    _backgroundColor = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)StyleKitName.gradientColor.CGColor, (id)StyleKitName.gradientColor2.CGColor], backgroundColorLocations);
    CGFloat tabBarLocations[] = {0, 1};
    _tabBar = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)StyleKitName.gradientColor5.CGColor, (id)StyleKitName.gradientColor6.CGColor], tabBarLocations);

}

#pragma mark Colors

+ (UIColor*)gradientColor { return _gradientColor; }
+ (UIColor*)gradientColor2 { return _gradientColor2; }
+ (UIColor*)gradientColor5 { return _gradientColor5; }
+ (UIColor*)gradientColor6 { return _gradientColor6; }
+ (UIColor*)color { return _color; }
+ (UIColor*)textForeground { return _textForeground; }

#pragma mark Gradients

+ (CGGradientRef)backgroundColor { return _backgroundColor; }
+ (CGGradientRef)tabBar { return _tabBar; }

#pragma mark Drawing Methods

+ (void)drawCanvas1
{
    [StyleKitName drawCanvas1WithFrame: CGRectMake(0, 0, 375, 667) resizing: StyleKitNameResizingBehaviorStretch];
}

+ (void)drawCanvas1WithFrame: (CGRect)targetFrame resizing: (StyleKitNameResizingBehavior)resizing
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = StyleKitNameResizingBehaviorApply(resizing, CGRectMake(0, 0, 375, 667), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 375, resizedFrame.size.height / 667);


    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* gradientColor3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.5];
    UIColor* gradientColor4 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.5];
    UIColor* fillColor2 = [UIColor colorWithRed: 0.012 green: 0.584 blue: 0.992 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0.329 green: 0.78 blue: 0.988 alpha: 1];
    UIColor* strokeColor2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.714 green: 0.983 blue: 0.934 alpha: 1];

    //// Gradient Declarations
    CGFloat linearGradientLocations[] = {0, 1};
    CGGradientRef linearGradient = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)gradientColor3.CGColor, (id)gradientColor4.CGColor], linearGradientLocations);

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 20, 375, 647)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, StyleKitName.backgroundColor, CGPointMake(187.5, 20), CGPointMake(187.5, 667), kNilOptions);
    CGContextRestoreGState(context);


    //// Page-
    {
        //// Group Начальный-экран
        {
            //// Defeault-screen 2
            {
                //// PlusButton
                {
                    //// Oval
                    {
                        //// path- 3 Drawing
                        UIBezierPath* path3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(164, 33, 50, 50)];
                        [fillColor2 setFill];
                        [path3Path fill];


                        //// path- 4 Drawing
                        UIBezierPath* path4Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(164, 33, 50, 50)];
                        CGContextSaveGState(context);
                        [path4Path addClip];
                        CGContextDrawLinearGradient(context, linearGradient,
                            CGPointMake(189, 51.83),
                            CGPointMake(189, 83),
                            kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
                        CGContextRestoreGState(context);
                        [strokeColor setStroke];
                        path4Path.lineWidth = 1;
                        [path4Path stroke];
                    }


                    //// Path 5 Drawing
                    UIBezierPath* path5Path = [UIBezierPath bezierPath];
                    [path5Path moveToPoint: CGPointMake(192.34, 54.51)];
                    [path5Path addLineToPoint: CGPointMake(201.5, 54.51)];
                    [path5Path addLineToPoint: CGPointMake(201.5, 61.49)];
                    [path5Path addLineToPoint: CGPointMake(192.34, 61.49)];
                    [path5Path addLineToPoint: CGPointMake(192.34, 71.96)];
                    [path5Path addLineToPoint: CGPointMake(186.23, 71.96)];
                    [path5Path addLineToPoint: CGPointMake(186.23, 61.49)];
                    [path5Path addLineToPoint: CGPointMake(177.07, 61.49)];
                    [path5Path addLineToPoint: CGPointMake(177.07, 54.51)];
                    [path5Path addLineToPoint: CGPointMake(186.23, 54.51)];
                    [path5Path addLineToPoint: CGPointMake(186.23, 44.04)];
                    [path5Path addLineToPoint: CGPointMake(192.34, 44.04)];
                    [path5Path addLineToPoint: CGPointMake(192.34, 54.51)];
                    [path5Path closePath];
                    path5Path.usesEvenOddFillRule = YES;
                    [fillColor setFill];
                    [path5Path fill];
                    [strokeColor2 setStroke];
                    path5Path.lineWidth = 1;
                    path5Path.miterLimit = 4;
                    [path5Path stroke];
                }
            }
        }
    }


    //// Page- 2
    {
        //// Group Начальный-экран 2
        {
            //// Defeault-screen 3
            {
                //// SettingsButton Drawing
                UIBezierPath* settingsButtonPath = [UIBezierPath bezierPath];
                [settingsButtonPath moveToPoint: CGPointMake(336, 63)];
                [settingsButtonPath addCurveToPoint: CGPointMake(331, 58) controlPoint1: CGPointMake(333.24, 63) controlPoint2: CGPointMake(331, 60.76)];
                [settingsButtonPath addCurveToPoint: CGPointMake(336, 53) controlPoint1: CGPointMake(331, 55.24) controlPoint2: CGPointMake(333.24, 53)];
                [settingsButtonPath addCurveToPoint: CGPointMake(341, 58) controlPoint1: CGPointMake(338.76, 53) controlPoint2: CGPointMake(341, 55.24)];
                [settingsButtonPath addCurveToPoint: CGPointMake(336, 63) controlPoint1: CGPointMake(341, 60.76) controlPoint2: CGPointMake(338.76, 63)];
                [settingsButtonPath addLineToPoint: CGPointMake(336, 63)];
                [settingsButtonPath closePath];
                [settingsButtonPath moveToPoint: CGPointMake(336, 48)];
                [settingsButtonPath addCurveToPoint: CGPointMake(326, 58) controlPoint1: CGPointMake(330.48, 48) controlPoint2: CGPointMake(326, 52.48)];
                [settingsButtonPath addCurveToPoint: CGPointMake(336, 68) controlPoint1: CGPointMake(326, 63.52) controlPoint2: CGPointMake(330.48, 68)];
                [settingsButtonPath addCurveToPoint: CGPointMake(346, 58) controlPoint1: CGPointMake(341.52, 68) controlPoint2: CGPointMake(346, 63.52)];
                [settingsButtonPath addCurveToPoint: CGPointMake(336, 48) controlPoint1: CGPointMake(346, 52.48) controlPoint2: CGPointMake(341.52, 48)];
                [settingsButtonPath addLineToPoint: CGPointMake(336, 48)];
                [settingsButtonPath closePath];
                [settingsButtonPath moveToPoint: CGPointMake(354.13, 65.61)];
                [settingsButtonPath addCurveToPoint: CGPointMake(346.85, 68.59) controlPoint1: CGPointMake(349.65, 67.44) controlPoint2: CGPointMake(349.63, 67.45)];
                [settingsButtonPath addCurveToPoint: CGPointMake(343.55, 76.45) controlPoint1: CGPointMake(345.79, 71.11) controlPoint2: CGPointMake(346.65, 69.06)];
                [settingsButtonPath addCurveToPoint: CGPointMake(335.68, 73.16) controlPoint1: CGPointMake(337.07, 73.74) controlPoint2: CGPointMake(338.62, 74.39)];
                [settingsButtonPath addCurveToPoint: CGPointMake(328.39, 76.14) controlPoint1: CGPointMake(333.17, 74.18) controlPoint2: CGPointMake(334.83, 73.5)];
                [settingsButtonPath addCurveToPoint: CGPointMake(325.41, 68.85) controlPoint1: CGPointMake(326.56, 71.65) controlPoint2: CGPointMake(326.55, 71.63)];
                [settingsButtonPath addCurveToPoint: CGPointMake(317.55, 65.55) controlPoint1: CGPointMake(322.89, 67.79) controlPoint2: CGPointMake(324.94, 68.65)];
                [settingsButtonPath addCurveToPoint: CGPointMake(320.85, 57.68) controlPoint1: CGPointMake(320.26, 59.08) controlPoint2: CGPointMake(319.61, 60.63)];
                [settingsButtonPath addCurveToPoint: CGPointMake(317.87, 50.39) controlPoint1: CGPointMake(320.33, 56.43) controlPoint2: CGPointMake(320.45, 56.73)];
                [settingsButtonPath addCurveToPoint: CGPointMake(325.15, 47.41) controlPoint1: CGPointMake(324.27, 47.77) controlPoint2: CGPointMake(322.52, 48.49)];
                [settingsButtonPath addCurveToPoint: CGPointMake(328.45, 39.55) controlPoint1: CGPointMake(326.2, 44.91) controlPoint2: CGPointMake(325.36, 46.93)];
                [settingsButtonPath addCurveToPoint: CGPointMake(336.32, 42.85) controlPoint1: CGPointMake(334.93, 42.26) controlPoint2: CGPointMake(333.38, 41.61)];
                [settingsButtonPath addCurveToPoint: CGPointMake(343.61, 39.86) controlPoint1: CGPointMake(337.57, 42.33) controlPoint2: CGPointMake(337.27, 42.45)];
                [settingsButtonPath addCurveToPoint: CGPointMake(346.59, 47.15) controlPoint1: CGPointMake(346.22, 46.25) controlPoint2: CGPointMake(346.08, 45.9)];
                [settingsButtonPath addCurveToPoint: CGPointMake(354.45, 50.45) controlPoint1: CGPointMake(349.11, 48.21) controlPoint2: CGPointMake(347.06, 47.35)];
                [settingsButtonPath addCurveToPoint: CGPointMake(351.15, 58.32) controlPoint1: CGPointMake(351.5, 57.48) controlPoint2: CGPointMake(352.29, 55.61)];
                [settingsButtonPath addCurveToPoint: CGPointMake(354.13, 65.61) controlPoint1: CGPointMake(351.67, 59.57) controlPoint2: CGPointMake(351.55, 59.27)];
                [settingsButtonPath addLineToPoint: CGPointMake(354.13, 65.61)];
                [settingsButtonPath closePath];
                [settingsButtonPath moveToPoint: CGPointMake(361, 47.78)];
                [settingsButtonPath addLineToPoint: CGPointMake(350.43, 43.34)];
                [settingsButtonPath addLineToPoint: CGPointMake(346.34, 33.34)];
                [settingsButtonPath addLineToPoint: CGPointMake(336.34, 37.43)];
                [settingsButtonPath addLineToPoint: CGPointMake(325.78, 33)];
                [settingsButtonPath addLineToPoint: CGPointMake(321.34, 43.57)];
                [settingsButtonPath addLineToPoint: CGPointMake(311.34, 47.66)];
                [settingsButtonPath addLineToPoint: CGPointMake(315.43, 57.66)];
                [settingsButtonPath addLineToPoint: CGPointMake(311, 68.22)];
                [settingsButtonPath addLineToPoint: CGPointMake(321.57, 72.66)];
                [settingsButtonPath addLineToPoint: CGPointMake(325.66, 82.66)];
                [settingsButtonPath addLineToPoint: CGPointMake(335.66, 78.57)];
                [settingsButtonPath addLineToPoint: CGPointMake(346.22, 83)];
                [settingsButtonPath addLineToPoint: CGPointMake(350.66, 72.43)];
                [settingsButtonPath addLineToPoint: CGPointMake(360.66, 68.34)];
                [settingsButtonPath addLineToPoint: CGPointMake(356.57, 58.34)];
                [settingsButtonPath addLineToPoint: CGPointMake(361, 47.78)];
                [settingsButtonPath closePath];
                settingsButtonPath.usesEvenOddFillRule = YES;
                [strokeColor2 setFill];
                [settingsButtonPath fill];
            }
        }
    }


    //// Page- 3
    {
        //// Group Начальный-экран 4
        {
            //// FilterButton Drawing
            UIBezierPath* filterButtonPath = [UIBezierPath bezierPath];
            [filterButtonPath moveToPoint: CGPointMake(37.5, 55.5)];
            [filterButtonPath addLineToPoint: CGPointMake(57.5, 55.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 58) controlPoint1: CGPointMake(58.88, 55.5) controlPoint2: CGPointMake(60, 56.62)];
            [filterButtonPath addCurveToPoint: CGPointMake(57.5, 60.5) controlPoint1: CGPointMake(60, 59.38) controlPoint2: CGPointMake(58.88, 60.5)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 60.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 58) controlPoint1: CGPointMake(36.12, 60.5) controlPoint2: CGPointMake(35, 59.38)];
            [filterButtonPath addCurveToPoint: CGPointMake(37.5, 55.5) controlPoint1: CGPointMake(35, 56.62) controlPoint2: CGPointMake(36.12, 55.5)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 55.5)];
            [filterButtonPath closePath];
            [filterButtonPath moveToPoint: CGPointMake(37.5, 73)];
            [filterButtonPath addLineToPoint: CGPointMake(57.5, 73)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 75.5) controlPoint1: CGPointMake(58.88, 73) controlPoint2: CGPointMake(60, 74.12)];
            [filterButtonPath addCurveToPoint: CGPointMake(57.5, 78) controlPoint1: CGPointMake(60, 76.88) controlPoint2: CGPointMake(58.88, 78)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 78)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 75.5) controlPoint1: CGPointMake(36.12, 78) controlPoint2: CGPointMake(35, 76.88)];
            [filterButtonPath addCurveToPoint: CGPointMake(37.5, 73) controlPoint1: CGPointMake(35, 74.12) controlPoint2: CGPointMake(36.12, 73)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 73)];
            [filterButtonPath closePath];
            [filterButtonPath moveToPoint: CGPointMake(37.5, 38)];
            [filterButtonPath addLineToPoint: CGPointMake(57.5, 38)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 40.5) controlPoint1: CGPointMake(58.88, 38) controlPoint2: CGPointMake(60, 39.12)];
            [filterButtonPath addCurveToPoint: CGPointMake(57.5, 43) controlPoint1: CGPointMake(60, 41.88) controlPoint2: CGPointMake(58.88, 43)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 43)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 40.5) controlPoint1: CGPointMake(36.12, 43) controlPoint2: CGPointMake(35, 41.88)];
            [filterButtonPath addCurveToPoint: CGPointMake(37.5, 38) controlPoint1: CGPointMake(35, 39.12) controlPoint2: CGPointMake(36.12, 38)];
            [filterButtonPath addLineToPoint: CGPointMake(37.5, 38)];
            [filterButtonPath closePath];
            [filterButtonPath moveToPoint: CGPointMake(30, 43)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 48) controlPoint1: CGPointMake(30, 45.76) controlPoint2: CGPointMake(32.24, 48)];
            [filterButtonPath addLineToPoint: CGPointMake(60, 48)];
            [filterButtonPath addCurveToPoint: CGPointMake(65, 43) controlPoint1: CGPointMake(62.76, 48) controlPoint2: CGPointMake(65, 45.76)];
            [filterButtonPath addLineToPoint: CGPointMake(65, 38)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 33) controlPoint1: CGPointMake(65, 35.24) controlPoint2: CGPointMake(62.76, 33)];
            [filterButtonPath addLineToPoint: CGPointMake(35, 33)];
            [filterButtonPath addCurveToPoint: CGPointMake(30, 38) controlPoint1: CGPointMake(32.24, 33) controlPoint2: CGPointMake(30, 35.24)];
            [filterButtonPath addLineToPoint: CGPointMake(20, 38)];
            [filterButtonPath addLineToPoint: CGPointMake(20, 33)];
            [filterButtonPath addLineToPoint: CGPointMake(15, 33)];
            [filterButtonPath addLineToPoint: CGPointMake(15, 73)];
            [filterButtonPath addCurveToPoint: CGPointMake(20, 78) controlPoint1: CGPointMake(15, 75.76) controlPoint2: CGPointMake(17.24, 78)];
            [filterButtonPath addLineToPoint: CGPointMake(20.55, 78)];
            [filterButtonPath addLineToPoint: CGPointMake(30, 78)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 83) controlPoint1: CGPointMake(30, 80.76) controlPoint2: CGPointMake(32.24, 83)];
            [filterButtonPath addLineToPoint: CGPointMake(60, 83)];
            [filterButtonPath addCurveToPoint: CGPointMake(65, 78) controlPoint1: CGPointMake(62.76, 83) controlPoint2: CGPointMake(65, 80.76)];
            [filterButtonPath addLineToPoint: CGPointMake(65, 73)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 68) controlPoint1: CGPointMake(65, 70.24) controlPoint2: CGPointMake(62.76, 68)];
            [filterButtonPath addLineToPoint: CGPointMake(35, 68)];
            [filterButtonPath addCurveToPoint: CGPointMake(30, 73) controlPoint1: CGPointMake(32.24, 68) controlPoint2: CGPointMake(30, 70.24)];
            [filterButtonPath addLineToPoint: CGPointMake(22.49, 73)];
            [filterButtonPath addCurveToPoint: CGPointMake(20, 70.51) controlPoint1: CGPointMake(21.11, 73) controlPoint2: CGPointMake(20, 71.88)];
            [filterButtonPath addLineToPoint: CGPointMake(20, 60.5)];
            [filterButtonPath addLineToPoint: CGPointMake(30, 60.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(35, 65.5) controlPoint1: CGPointMake(30, 63.26) controlPoint2: CGPointMake(32.24, 65.5)];
            [filterButtonPath addLineToPoint: CGPointMake(60, 65.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(65, 60.5) controlPoint1: CGPointMake(62.76, 65.5) controlPoint2: CGPointMake(65, 63.26)];
            [filterButtonPath addLineToPoint: CGPointMake(65, 55.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(60, 50.5) controlPoint1: CGPointMake(65, 52.74) controlPoint2: CGPointMake(62.76, 50.5)];
            [filterButtonPath addLineToPoint: CGPointMake(35, 50.5)];
            [filterButtonPath addCurveToPoint: CGPointMake(30, 55.5) controlPoint1: CGPointMake(32.24, 50.5) controlPoint2: CGPointMake(30, 52.74)];
            [filterButtonPath addLineToPoint: CGPointMake(20, 55.5)];
            [filterButtonPath addLineToPoint: CGPointMake(20, 43)];
            [filterButtonPath addLineToPoint: CGPointMake(30, 43)];
            [filterButtonPath closePath];
            filterButtonPath.usesEvenOddFillRule = YES;
            [strokeColor2 setFill];
            [filterButtonPath fill];
        }
    }


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 618, 375, 49)];
    [color3 setFill];
    [rectangle2Path fill];


    //// Cleanup
    CGGradientRelease(linearGradient);
    
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
