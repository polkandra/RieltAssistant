//
//  NewObjectViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NewObjectViewController.h"


@interface NewObjectViewController ()
@end

@implementation NewObjectViewController
@synthesize objectNameTextField, priceTextField;



#pragma mark - VC Lyficycle

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

/*
- (IBAction)saveButtonTaped:(UIButton *)sender {
    
    MainViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:controller animated:YES];

    
    [objectNameTextField resignFirstResponder];
    [priceTextField resignFirstResponder];
   
    NSString* objectName = [objectNameTextField text];
    NSString* objectPrice = [priceTextField text];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:objectName forKey:@"objectName"];
    [defaults setObject:objectPrice forKey:@"objectPrice"];
    [defaults synchronize];  
   
    
}*/


- (IBAction)addPlaceToMapButton:(UIButton *)sender {



}



- (IBAction)addPhotosButton:(UIButton *)sender {





}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toMain"])
    {
        
      // MainViewController *vc = segue.destinationViewController;
      
        
        
        self.myTextObjectName = self.objectNameTextField.text;
        self.myTextObjectPrice = self.priceTextField.text;
        
    
  }

}





@end
