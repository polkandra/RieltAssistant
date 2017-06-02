//
//  UIPageViewController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 31.05.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EbmeddedImageController.h"

@interface UIPageViewControllerScene : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>


@property (strong, nonatomic)  NSMutableArray *pageVCArray;

@property (strong, nonatomic) UIPageViewController *pageViewController;




@end
