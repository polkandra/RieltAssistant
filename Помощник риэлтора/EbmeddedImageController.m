//
//  EbmeddedImageController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 31.05.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "EbmeddedImageController.h"

@interface EbmeddedImageController ()

@end

@implementation EbmeddedImageController
@synthesize pageIndex,imageFile;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.ImageInEmbeddedView.image = imageFile;
    
   
}










@end
