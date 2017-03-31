//
//  NewObjectViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NewObjectViewController.h"
#import "MainViewController.h"

@interface NewObjectViewController ()

@end

@implementation NewObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}











- (IBAction)saveAction:(UIBarButtonItem *)sender {




}

- (IBAction)addPlaceToMapButton:(UIButton *)sender {



}



- (IBAction)addPhotosButton:(UIButton *)sender {





}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mainVC"]) {
        
        MainViewController* mVC = [segue destinationViewController];
    self
    
    
    }
}






@end
