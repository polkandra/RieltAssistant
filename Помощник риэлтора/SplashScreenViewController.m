//
//  SplashScreenViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 12.12.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self performSelector:@selector(showNavController) withObject:nil afterDelay:1];
}

-(void) showNavController {
    
    [self performSegueWithIdentifier:@"fromSplashScreen" sender:self];
}

@end
