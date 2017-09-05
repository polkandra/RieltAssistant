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
@synthesize pageViewController, detailItem;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self fetchPhotosArray];
    [self setPageViewControllerDirection];

    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.delegate = self;
    self.dataSource = self;
   
    
}



-(void)setPageViewControllerDirection {
    EbmeddedImageController *initialVC = (EbmeddedImageController*)[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}



-(void)fetchPhotosArray {
    
   // NSError *error;
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
   // self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.sourceArray = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
   
  
}



-(void)viewWillAppear:(BOOL)animated  {
   
    [super viewWillAppear:YES];
    [self fetchPhotosArray];
    [self setPageViewControllerDirection];

}


#pragma mark - UIPageViewControllerDataSource,UIPageViewControllerDelegate


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((EbmeddedImageController*) viewController).pageIndex;
        if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];

}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((EbmeddedImageController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.sourceArray count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}



- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
   
    return [self.sourceArray count];
}



- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}





#pragma mark - Helper Method

- (EbmeddedImageController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.sourceArray count] == 0) || (index >= [self.sourceArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    
    EbmeddedImageController *embeddedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"embedded"];
    embeddedVC.imageFile = [self.sourceArray objectAtIndex:index];
    embeddedVC.pageIndex = index;
    
   
    return embeddedVC;
    
    
}


@end
