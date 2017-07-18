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
@synthesize  myPhotosArray, tableView, myArrayWithPhotoData,detailItem;


#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSInteger row = 1;
    NSInteger section = 4;
    self.expandedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    NSLog(@"my array = %@",self.myData);
    
    self.saveRightBarButton.enabled = YES;
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsMultipleSelection = YES;
    self.tableView.allowsSelection = YES;
    
    
    [self setDelegatesForPickerView];
    [self setDelegatesForTextFields];
    [self addGestureRecognizer];
    [self pickerViewWithData];
    
    self.myData = [[NSMutableArray alloc] init];
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];
    self.myArrayWithPhotoData = [[NSMutableArray alloc] init];
    self.arrayForPVC = [[NSMutableArray alloc] init];
    
    
    /*if([myPhotosArray count] > 0) {
        
        self.addPlaceOnMapButton.enabled = NO;
        
    }else{
        
        self.addPlaceOnMapButton.enabled = YES;
    }*/
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor46]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationItem setTitle:@"Новый объект"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:22]}];

    /*[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;*/

}




#pragma mark - Actions



- (IBAction)addPlaceToMapButton:(UIButton *)sender {
    
   // MapViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mapVC"];
   // [self presentViewController:mapVC animated:YES completion:nil];
    
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


#pragma mark - UITableViewDelegate


/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    
    
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        self.expandedIndexPath = nil;
    
    }else{
        self.expandedIndexPath = indexPath;
    }
    /*[[self tableView] reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem: 0 inSection:4]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView endUpdates];
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        
        return 200.0; // Expanded height
   
    }
    
    return 70.0; // Normal height
    
}*/

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toMain"]) {
        
     //   if (self.detailItem) {
        
        EstateObjectEntity* object =
        [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity"
                                      inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
        
        MainViewController *controller = segue.destinationViewController;
        
        controller.myPhotosData = [[NSMutableArray alloc] init];
        controller.myPhotosData = self.myPhotosArray;
        //controller.myPhotosData = self.myArrayWithPhotoData;
        
        controller.object = object;
            
        
        //[object setValue:[self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]] forKey:@"roomQuantity"];
       
         object.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
        
        //[object setValue:self.phoneTextField.text forKey:@"phoneNumber"];
        object.phoneNumber = self.phoneTextField.text;
        
        //[object setValue:self.objectTypeLabelInCell.text forKey:@"typeOfProperty"];
        object.typeOfProperty = self.objectTypeLabelInCell.text;
        
       // [object setValue:self.actionTypeLabelInCell.text forKey:@"actionByProperty"];
        object.actionByProperty = self.actionTypeLabelInCell.text;
            
           if (( self.totalSquareTextField.text.length == 0 )){
                
                
                //[object setValue:@"--" forKey:@"emptyWholeArea"];
               object.wholeArea = @"--";
                
            }else{
                
               //[object setValue:self.totalSquareTextField.text forKey:@"wholeArea"];
                object.wholeArea = self.totalSquareTextField.text;
            }
            
            if (( self.livingSquareTextField.text.length == 0 )){
                
               // [object setValue:@"--" forKey:@"emptyLivingAreaArea"];
               object.livingArea = @"--";
                
            }else{
                
                //[object setValue:self.livingSquareTextField.text forKey:@"livingArea"];
                object.livingArea = self.livingSquareTextField.text;
            }
            
            
            if (( self.kitchenSquareTextField.text.length == 0 )) {
                
                
                //[object setValue:@"--" forKey:@"emptyKitchenArea"];
                object.kitchenArea = @"--";
                
            }else{
                
                
               // [object setValue:self.kitchenSquareTextField.text forKey:@"kitchenArea"];
                object.kitchenArea = self.kitchenSquareTextField.text;
            }
            
            
            if ((self.objectNameTextField.text.length == 0)) {
                
                //[object setValue:@"Имя не указано" forKey:@"noName"];
                object.discription = @"Имя не указано";
                
            }else{
                
                 //[object setValue:self.objectNameTextField.text forKey:@"discription"];
                object.discription = self.objectNameTextField.text;
                
            }
            
            
        
        if ((self.ownerNameTextField.text.length == 0)) {
                
            
            // [object setValue:@"Собственник не указан" forKey:@"noOwner"];
             object.owner = @"Собственник не указан";
                
            }else{
                
               //[object setValue:self.ownerNameTextField.text forKey:@"owner"];
                object.owner = self.ownerNameTextField.text;
            }
            
            if ((self.adressTextfield.text.length == 0)) {
                
                
                //[object setValue:@"Адрес не указан" forKey:@"noAddress"];
                object.address = @"Адрес не указан";
                
            }else{
                
                
                //[object setValue:self.adressTextfield.text forKey:@"address"];
                object.address = self.adressTextfield.text;
            }
            
            
            if ((self.priceTextField.text.length == 0)) {
                
                
                //[object setValue:@"Цена не указана" forKey:@"noPrice"];
                object.price = @"Цена не указана";
                
            }else{
                
                NSMutableString *concatString = self.priceTextField.text;
                concatString = [concatString stringByAppendingString:@" Рублей"];
                
                object.price = concatString;
                
               // [object setValue:concatString forKey:@"price"];
           
            }
       
            if ([self.myArrayWithPhotoData count] == 0) {
                
                UIImage *image = [UIImage imageNamed:@"emptyObject2"];
               
                NSData* pictureData = UIImageJPEGRepresentation(image,0);
                
                [self.myArrayWithPhotoData addObject:pictureData];
                
                //array for PVC
                [self.myPhotosArray addObject:image];
                
                
                object.picture = [self.myArrayWithPhotoData firstObject];
               // object.picture = [self.arrayForPVC firstObject];
               // [object setValue:[self.myArrayWithPhotoData firstObject] forKey:@"picture"];
            
            }else{
                
                object.picture = [self.myArrayWithPhotoData firstObject];
               // object.picture = [self.arrayForPVC firstObject];
               // [object setValue:[self.myArrayWithPhotoData firstObject] forKey:@"picture"];
            
            }
        
        
            
            
     /*   }else{
            
            NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
            
            [detailItem setValue:self.objectNameTextField.text forKey:@"discription"];
            [detailItem setValue:self.adressTextfield.text forKey:@"address"];
            [detailItem setValue:self.ownerNameTextField.text forKey:@"owner"];
            [detailItem setValue:self.priceTextField.text forKey:@"price"];
            [detailItem setValue:self.phoneTextField.text forKey:@"phoneNumber"];
            [detailItem setValue: self.objectTypeLabelInCell.text forKey:@"typeOfProperty"];
            [detailItem setValue: self.actionTypeLabelInCell.text forKey:@"actionByProperty"];
            [detailItem setValue: [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]] forKey:@"roomQuantity"];
            [detailItem setValue: self.totalSquareTextField.text forKey:@"wholeArea"];
            [detailItem setValue: self.livingSquareTextField.text forKey:@"livingArea"];
            [detailItem setValue: self.kitchenSquareTextField.text forKey:@"kitchenArea"];
            
            [detailItem setValue:[self.myArrayWithPhotoData firstObject] forKey:@"picture"];
            
            //}*/
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
            
   //     }
        
        
        
    } else if ([segue.identifier isEqualToString:@"toMapView"]) {
        
        AddToMapVC *mapVC = (AddToMapVC *)segue.destinationViewController;
        mapVC.pinPhotosArray =  [[NSMutableArray alloc] init];
        mapVC.pinPhotosArray = self.myPhotosArray;
        
        if ((self.objectNameTextField.text.length == 0)) {
            
            mapVC.titleText = @"Введите название объекта";
            
        }else{
            mapVC.titleText = self.objectNameTextField.text;
        }
        
        if ((self.priceTextField.text.length == 0)) {
            
            mapVC.subTitleText =  @"Введите цену объекта";
            
        }else{
            
            NSMutableString *concatString = self.priceTextField.text;
            concatString = [concatString stringByAppendingString:@" Рублей"];
            self.priceTextField.text = concatString;
            
            mapVC.subTitleText = self.priceTextField.text;
            
        }
        
    }
    
}






        /* self.myObject = [[EstateObject alloc] init];
        
        // passing data in MainViewController
        MainViewController *controller = segue.destinationViewController;
        controller.myPhotosData = myPhotosArray;
        
        
       //setting picker value and passing it
        
        NSString *selValue = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
        
        self.myObject.roomQuantity = selValue;
       
                
        self.myObject.phoneNumber = self.phoneTextField.text;
        
        self.myObject.typeOfProperty = self.objectTypeLabelInCell.text;
        self.myObject.actionByProperty = self.actionTypeLabelInCell.text;
        
        
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
        
        
        if ([self.myPhotosArray count] == 0) {
            
            UIImage *image = [UIImage imageNamed:@"emptyObject2"];
            
            [self.myPhotosArray addObject:image];
            
            self.myObject.picture = [self.myPhotosArray firstObject];
            
        }else{
            
            self.myObject.picture = [self.myPhotosArray firstObject];
            
        }
        
    
    
    
    } else if ([segue.identifier isEqualToString:@"toMapView"]) {
        
        AddToMapVC *mapVC = (AddToMapVC *)segue.destinationViewController;
        mapVC.pinPhotosArray =  [[NSMutableArray alloc] init];
        mapVC.pinPhotosArray = self.myPhotosArray;
        
        if ((self.objectNameTextField.text.length == 0)) {
          
            mapVC.titleText = @"Введите название объекта";
        
        }else{
             mapVC.titleText = self.objectNameTextField.text;
        }
        
         if ((self.priceTextField.text.length == 0)) {
          
             mapVC.subTitleText =  @"Введите цену объекта";
         
         }else{
             
             NSMutableString *concatString = self.priceTextField.text;
             concatString = [concatString stringByAppendingString:@" Рублей"];
             self.priceTextField.text = concatString;
             
             mapVC.subTitleText = self.priceTextField.text;

         }
      
    }
    
}*/



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
    
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    
    NSData *data = UIImageJPEGRepresentation(image,0);
    
    
    
    [self.myArrayWithPhotoData addObject:data];
    
    [self.myPhotosArray addObject:image];
    
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
    
    CollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
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
