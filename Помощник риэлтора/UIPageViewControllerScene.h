//
//  UIPageViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 31.05.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EbmeddedImageController.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"

@interface UIPageViewControllerScene : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, NSCoding>




@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) EstateObjectEntity* detailItem;

@property (strong, nonatomic)  NSMutableArray *retrievedArray;
@property (strong, nonatomic)  NSMutableArray *sourceArray;
@property (strong, nonatomic)  NSMutableArray *pageVCArray;

@end
