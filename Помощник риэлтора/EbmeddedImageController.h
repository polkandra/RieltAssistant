//
//  EbmeddedImageController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 31.05.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailObjectController.h"
#import "NewObjectViewController.h"
#import "DataManager.h"
//#import "EstateObjectEntity+CoreDataClass.h"


@interface EbmeddedImageController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ImageInEmbeddedView;

@property NSUInteger pageIndex;
@property UIImage *imageFile;


@end
