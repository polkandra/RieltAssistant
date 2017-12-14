//
//  MapAnnotation.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect  viewRect = CGRectMake(-20, -20, 40, 40);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:viewRect];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.pinImage = imageView;
        
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    
    self.pinImage.image = image;
}



@end
