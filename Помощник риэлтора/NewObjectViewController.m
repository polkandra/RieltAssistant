//
//  NewObjectViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NewObjectViewController.h"


@interface NewObjectViewController () 

@property(assign, nonatomic) BOOL isSelected;

@end

@implementation NewObjectViewController
@synthesize  myPhotosArray, tableView;


#pragma mark - VC Lyficycle

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"my array = %@",self.myData);
    
    self.saveRightBarButton.enabled = YES;
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.collectionView.allowsMultipleSelection = YES;
    
    
    
    [self setDelegatesForPickerView];
    [self setDelegatesForTextFields];
    [self addGestureRecognizer];
    [self pickerViewWithData];
   
    self.myData = [[NSMutableArray alloc] init];
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];


    
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



- (IBAction)deletePhotosButton:(UIButton *)sender {
    
    if (self.collectionView) {
        
        
        [self.collectionView performBatchUpdates:^{
            
            
            NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
            
            NSMutableIndexSet *removeIndexes = [NSMutableIndexSet new];
            
            for (NSIndexPath *path in selectedItemsIndexPaths) {
                [removeIndexes addIndex:path.item];
                
            }
            [self.myPhotosArray removeObjectsAtIndexes:removeIndexes];
            [self.collectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
            
        } completion:nil];
    }
}


#pragma mark - Segues


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMain"]) {
        
        self.myObject = [[EstateObject alloc] init];
        
        
        NSString *selValue = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
        
        self.myObject.roomQuantity = selValue;
       
        
       
        
        if (( self.totalSquareTextField.text.length == 0 )){
            
            self.myObject.wholeArea = @"--";
        
        }else{
            self.myObject.wholeArea = self.totalSquareTextField.text;
        }
        
        
        
        if (( self.livingSquareTextField.text.length == 0 )){
            
            self.myObject.livingArea = @"--";
        
        }else{
            self.myObject.livingArea = self.livingSquareTextField.text;
        }
        
        
        
        if (( self.kitchenSquareTextField.text.length == 0 )) {
            
            self.myObject.kitchenArea = @"--";
        
        }else{
            
            self.myObject.kitchenArea = self.kitchenSquareTextField.text;
        }
        
        
        self.myObject.discription = self.objectNameTextField.text;
        
       
        if ((self.ownerNameTextField.text.length == 0)) {
            
            self.myObject.owner = @"Собственник не указан";
            
        }else{
            
            self.myObject.owner = self.ownerNameTextField.text;
        }
        
        if ((self.adressTextfield.text.length == 0)) {
            
            self.myObject.address = @"Адрес не указан";
            
        }else{
            
            self.myObject.address = self.adressTextfield.text;
        }
        
        
        if ((self.priceTextField.text.length == 0)) {
            
            self.myObject.price = @"Цена не указана";
            
        }else{
            
            NSMutableString *concatString = self.priceTextField.text;
            concatString = [concatString stringByAppendingString:@" Рублей"];
            self.myObject.price = concatString;
            
        }
        
        
        if ([myPhotosArray count] == 0) {
            
            UIImage *image = [UIImage imageNamed:@"emptyObject2"];
            
            [myPhotosArray addObject:image];
            self.myObject.picture = [myPhotosArray firstObject];
            
        }else{
            
            self.myObject.picture = [myPhotosArray firstObject];
            
        }
        
    }
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"toMain"]) {
        
        
        if ((self.objectNameTextField.text.length == 0)) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Внимание" message:@"Введите название объекта" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:action];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            return NO;
        }
    }
    return YES;
}


#pragma mark - Unwind Segues

// unwind segue from RoomType VC

- (IBAction)unwindToNewObjectVCAfterSaveButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"unwindAfterSaveTapped"]) {
        
        RoomTypeController *controller = segue.sourceViewController;
        
        
        self.objectTypeLabelInCell.text = [self.myData firstObject];
        self.actionTypeLabelInCell.text = [self.myData lastObject];
        
       
        [self.tableView reloadData];
        
    }

    NSLog(@"my array bom = %@",self.myData);

}


// unwind segue from RoomType VC

- (IBAction)unwindToNewObjectVCAfterBackButtonTapped:(UIStoryboardSegue *)segue {
    
}





#pragma mark - UIImagePickerControllerDelegate



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImageView* image = info[UIImagePickerControllerOriginalImage];
    EstateObject* photoObject = [[EstateObject alloc] init];
    
    photoObject.picture = image;
    
    [myPhotosArray addObject:image];
    
    [self.collectionView reloadData];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.myPhotosArray count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"CVcell";
    
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.objectView.image = [myPhotosArray objectAtIndex:indexPath.row];
    
    return cell;
  
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
}



-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
}




#pragma mark - UICollectionViewDelegateFlowLayout


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}





#pragma mark - UITextFieldDelegate


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

-(void)setDelegatesForTextFields {
    self.priceTextField.delegate = self;
    self.objectNameTextField.delegate = self;
    self.adressTextfield.delegate = self;
    self.totalSquareTextField.delegate = self;
    self.livingSquareTextField.delegate = self;
    self.kitchenSquareTextField.delegate = self;
    self.priceTextField.delegate = self;
    self.metroFloorTextField.delegate = self;
    self.ownerNameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.extraInfoTextField.delegate = self;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.objectNameTextField resignFirstResponder];
    [self.adressTextfield resignFirstResponder];
    [self.totalSquareTextField resignFirstResponder];
    [self.livingSquareTextField resignFirstResponder];
    [self.kitchenSquareTextField resignFirstResponder];
    [self.priceTextField resignFirstResponder];
    [self.metroFloorTextField resignFirstResponder];
    [self.ownerNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.extraInfoTextField resignFirstResponder];
    
    return NO;
    
}




#pragma mark - UITapGestureRecognizer Method

-(void)addGestureRecognizer {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}


- (void)hideKeyboard {
    
    [self.view endEditing:YES];
}



#pragma mark - UIPickerViewDelegate

-(void)pickerViewWithData {
    
    
    self.pickerViewArrayRoomQuantity = [[NSMutableArray alloc] initWithObjects:@"1 комната",@" 2 комнаты",@"3 комнаты",@"4 комнаты",@"5 комнат и более", nil];
    self.pickerViewArrayCity = [[NSMutableArray alloc] initWithObjects:@"Москва",@"Санкт-Петербург",@"Екатеринбург",@"Сочи", nil];
       
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];
    
}


#pragma mark - UIPickerViewDataSource

-(void)setDelegatesForPickerView {
    
    
    self.cityPicker.delegate = self;
    self.roomPicker.delegate = self;

}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;


}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger quantity;
    
    if (pickerView == _roomPicker) {
        
        quantity = [_pickerViewArrayRoomQuantity count];
    }
    
    else {
        quantity = [_pickerViewArrayCity count];
        
    }
    
    return quantity;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    
    if (pickerView == _roomPicker) {
    
    
        title = [_pickerViewArrayRoomQuantity objectAtIndex:row];
    }
    
    else if (pickerView == _cityPicker) {
    
        title = [_pickerViewArrayCity objectAtIndex:row];
        
    }
    
    return title;
    
}



@end
