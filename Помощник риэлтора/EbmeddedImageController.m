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
   
    
    //self.imageFile = [UIImage imageWithData:[detailItem valueForKey:@"picture"]];
   
    self.ImageInEmbeddedView.image = imageFile;
    
   
    
   // self.ImageInEmbeddedView.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];


}










@end
