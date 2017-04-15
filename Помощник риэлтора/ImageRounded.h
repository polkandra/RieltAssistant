//
//  ImageRounded.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 15.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageRounded : UIImage
-(UIImage *)makeRoundedImage:(UIImage *) image radius: (float) radius;
@end
