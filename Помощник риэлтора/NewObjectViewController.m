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
@synthesize  myPhotosArray, delegate;



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




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.myObject = [[EstateObject alloc] init];
    self.myObject.discription = self.objectNameTextField.text;
    self.myObject.price = self.priceTextField.text;
    self.myObject.picture = [myPhotosArray objectAtIndex:0];
    
}



#pragma mark - UIImagePickerControllerDelegate



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    EstateObject* photoObject = [[EstateObject alloc] init];
    
    photoObject.picture = image;
    
    [myPhotosArray addObject:image];
    
    [self.collectionView reloadData];
    
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
    
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    
    cell.objectView.image = [myPhotosArray objectAtIndex:indexPath.row];
    
    return cell;
  
}







@end
