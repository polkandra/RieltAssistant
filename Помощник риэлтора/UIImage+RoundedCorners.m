//
//  UIImage+RoundedCorners.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 15.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "UIImage+RoundedCorners.h"

@implementation UIImage (RoundedCorners)



-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

@end
