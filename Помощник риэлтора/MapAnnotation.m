//
//  MapAnnotation.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // make sure the x and y of the CGRect are half it's
        // width and height, so the callout shows when user clicks
        // in the middle of the image
        CGRect  viewRect = CGRectMake(-20, -20, 40, 40);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:viewRect];
        
        // keeps the image dimensions correct
        // so if you have a rectangle image, it will show up as a rectangle,
        // instead of being resized into a square
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.pinImage = imageView;
        
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    // when an image is set for the annotation view,
    // it actually adds the image to the image view
    self.pinImage.image = image;
}
@end
