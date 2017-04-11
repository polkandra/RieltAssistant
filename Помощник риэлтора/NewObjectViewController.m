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
@synthesize objectNameTextField, priceTextField, myPhotosArray;



#pragma mark - VC Lyficycle

- (void)viewDidLoad {
    [super viewDidLoad];


    
    
    self.myPhotosArray = [[NSMutableArray alloc] init];

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

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* firstAction = [UIAlertAction actionWithTitle:@"Сделать снимок" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
       
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    
    
    }];

    UIAlertAction* secondAction = [UIAlertAction actionWithTitle:@"Выбрать из галереи" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        

        
    }];
    
    
    UIAlertAction* cancellAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"You pressed button cancell");
    }];
    
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:cancellAction];
    
    [self presentViewController:alert animated:YES completion:nil];
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
 #pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage* image = info[UIImagePickerControllerEditedImage];
    //self.addPhotosView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.myPhotosArray count];
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"CVcell";
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    EstateObject* newObject2 = [self.myPhotosArray objectAtIndex:indexPath.row];
    
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:300];
    recipeImageView.image = newObject2.picture;
    
    
    return cell;
  
}







@end
