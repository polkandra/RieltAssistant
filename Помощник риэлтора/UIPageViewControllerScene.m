//
//  UIPageViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 31.05.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "UIPageViewControllerScene.h"

@interface UIPageViewControllerScene ()

@end

@implementation UIPageViewControllerScene
@synthesize pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
   


       
    NSLog(@"Page array = %lu",(unsigned long)[self.pageVCArray count]);
   
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    self.dataSource = self;
    
    
    EbmeddedImageController *initialVC = (EbmeddedImageController*)[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
       
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}



#pragma mark - UIPageViewControllerDataSource,UIPageViewControllerDelegate


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((EbmeddedImageController*) viewController).pageIndex;
    
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];

}




- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((EbmeddedImageController*) viewController).pageIndex;
    
    
  
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageVCArray count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}



- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
   
    return [self.pageVCArray count];
}



- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}





#pragma mark - Helper Method

- (EbmeddedImageController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.pageVCArray count] == 0) || (index >= [self.pageVCArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    
    EbmeddedImageController *embeddedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"embedded"];
    
   
    
    embeddedVC.imageFile = [self.pageVCArray objectAtIndex:index];
    embeddedVC.pageIndex = index;
    
   
    return embeddedVC;
    
    
}










@end
