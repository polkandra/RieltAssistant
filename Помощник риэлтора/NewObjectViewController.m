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
@synthesize  myPhotosArray, tableView, myArrayWithPhotoData, detailItem, hideButton, saveSecondButton, detailItemFromDetailObjectVC,  myRetrievedPics;


#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*NSInteger row = 1;
    NSInteger section = 4;
    self.expandedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];*/
    
    //NSLog(@"my array = %@",self.myData);
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsMultipleSelection = YES;
    self.tableView.allowsSelection = YES;
    
    [self updateUI];
    [self setDelegatesForPickerView];
    [self setDelegatesForTextFields];
    [self addGestureRecognizer];
    [self pickerViewWithData];
    
    
    [self hideShowDeleteSaveButtons];
    [self showHideDeleteButton];
    [self hideBackButton];
    
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];
    self.myArrayWithPhotoData = [[NSMutableArray alloc] init];
    self.myData1 = [[NSMutableArray alloc] init];
    
    
   
    
}




-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
      
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self fetchPhotos];
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor46]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //  [self.navigationItem setTitle:@"Новый объект"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"avenir" size:22]}];
    
    /*[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     self.navigationController.navigationBar.translucent = YES;*/
    
    /*NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
     self.myRetrievedPics = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];*/
  

}



#pragma mark - Helpers


-(void)hideBackButton {
    
    if ((!self.navigationItem.leftBarButtonItem)) {
        
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:[detailItem valueForKey:@"discription"] style:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem = newBackButton;
        
    }
}



-(void) back:(UIBarButtonItem *)sender {
    
    if (self.detailItem) {
        
        NSData* pictureData = UIImageJPEGRepresentation([self.myRetrievedPics firstObject],0);
        detailItem.picture = pictureData;
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}




- (void) showHideDeleteButton {

    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    if(selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        self.deleteButton.hidden = YES;
    }
}


-(void)hideShowDeleteSaveButtons{
    
    if (self.hideButton == YES) {
        
        self.saveSecondButton.hidden = YES;
        self.deleteSecondButton.hidden = YES;
        self.cancelSecondButton.hidden = YES;
        
    }else{
        
        self.saveSecondButton.hidden = NO;
        self.deleteSecondButton.hidden = NO;
        self.cancelSecondButton.hidden = NO;
        
    }
}


-(void)fetchPhotos {
    
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.myRetrievedPics = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
    
   // self.itemCount = self.myRetrievedPics.count;
    
    if ([self.myRetrievedPics containsObject:[UIImage imageNamed:@"emptyObject2"]]) {
        [self.myRetrievedPics removeObject:[UIImage imageNamed:@"emptyObject2"]];
    }
    
}


-(void)updateUI {
    
    if (self.detailItem) {
      
        [self.objectNameTextField setText:[self.detailItem valueForKey:@"discription"]];
        [self.adressTextfield setText:[self.detailItem valueForKey:@"address"]];
        [self.ownerNameTextField setText:[self.detailItem valueForKey:@"owner"]];
        [self.priceTextField setText:[self.detailItem valueForKey:@"price"]];
        [self.phoneTextField setText:[self.detailItem valueForKey:@"phoneNumber"]];
        [self.objectTypeLabelInCell setText:[self.detailItem valueForKey:@"typeOfProperty"]];
        [self.actionTypeLabelInCell setText:[self.detailItem valueForKey:@"actionByProperty"]];
        //[[self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]] valueForKey:@"roomQuantity"];
        [self.totalSquareTextField setText:[self.detailItem valueForKey:@"wholeArea"]];
        [self.livingSquareTextField setText:[self.detailItem valueForKey:@"livingArea"]];
        [self.kitchenSquareTextField setText:[self.detailItem valueForKey:@"kitchenArea"]];
        
        
    }
}



#pragma mark - Actions


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
        
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject:[UIImage imageNamed:@"emptyObject2"]];
            
        }
        
        
        MainViewController *controller = (MainViewController *)segue.destinationViewController;
        
        
        EstateObjectEntity* object =
        [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity"
                                      inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
        
        
        controller.object = object;
        
        object.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
        object.phoneNumber = self.phoneTextField.text;
        object.typeOfProperty = self.objectTypeLabelInCell.text;
        object.actionByProperty = self.actionTypeLabelInCell.text;
        
        if (( self.totalSquareTextField.text.length == 0 )){
            
            object.wholeArea = @"--";
            
        }else{
            
            object.wholeArea = self.totalSquareTextField.text;
        }
        
        
        if (( self.livingSquareTextField.text.length == 0 )){
            
            object.livingArea = @"--";
            
        }else{
            
            object.livingArea = self.livingSquareTextField.text;
        }
        
        
        if (( self.kitchenSquareTextField.text.length == 0 )) {
            
            object.kitchenArea = @"--";
            
        }else{
        
            object.kitchenArea = self.kitchenSquareTextField.text;
        }
        
        
        if ((self.objectNameTextField.text.length == 0)) {
            
            object.discription = @"Имя не указано";
            
        }else{
            
            object.discription = self.objectNameTextField.text;
            
        }
        
        
        
        if ((self.ownerNameTextField.text.length == 0)) {
            
            object.owner = @"Собственник не указан";
            
        }else{
            
            object.owner = self.ownerNameTextField.text;
        }
        
        
       
        if ((self.adressTextfield.text.length == 0)) {
            
            object.address = @"Адрес не указан";
            
        }else{
            
            object.address = self.adressTextfield.text;
        }
        
        
       
        if ((self.priceTextField.text.length == 0)) {
            
            object.price = @"Цена не указана";
            
        }else{
            
            NSMutableString *concatString = self.priceTextField.text;
            concatString = [concatString stringByAppendingString:@" Рублей"];
            
            object.price = concatString;
            
        }
        
        
        if (self.myArrayWithPhotoData.count == 0) {
            
            UIImage *image = [UIImage imageNamed:@"emptyObject2"];
            NSData* pictureData = UIImageJPEGRepresentation(image,0);
            
            [self.myArrayWithPhotoData addObject:pictureData];
            [self.myPhotosArray addObject:image];
            
            
            
            object.picture = [self.myArrayWithPhotoData firstObject];
            
        }else{
            
            object.picture = [self.myArrayWithPhotoData firstObject];
            
        }
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myPhotosArray];
        object.arrayOfUsersPics = arrayData;
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        
        
        
    } else if ([segue.identifier isEqualToString:@"unwindAndSaveToDetail"]) {
        
        DetailObjectController *doc = (DetailObjectController*)segue.destinationViewController;
        
        doc.detailItem = self.detailItem;
        doc.sourceArray = [[NSMutableArray alloc] init];
        doc.sourceArray = self.myRetrievedPics;
        
        if (self.myRetrievedPics.count == 0) {
         
         [self.myRetrievedPics addObject:[UIImage imageNamed:@"emptyObject2"]];
         
         }
        
         // UPDATING EXISTING OBJECTS.
       
        if (self.detailItem) {
            
            detailItem.discription = self.objectNameTextField.text;
            detailItem.address = self.adressTextfield.text;
            detailItem.owner = self.ownerNameTextField.text;
            detailItem.price = self.priceTextField.text;
            detailItem.phoneNumber = self.phoneTextField.text;
            detailItem.typeOfProperty = self.objectTypeLabelInCell.text;
            detailItem.actionByProperty = self.actionTypeLabelInCell.text;
            detailItem.wholeArea = self.totalSquareTextField.text;
            detailItem.livingArea = self.livingSquareTextField.text;
            detailItem.kitchenArea = self.kitchenSquareTextField.text;
            detailItem.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
            
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myRetrievedPics];
            detailItem.arrayOfUsersPics = arrayData;
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        
        }else{
            
            // CREATING A NEW OBJECT.
            
            EstateObjectEntity* object =
            [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity"
                                           inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
            
            
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myRetrievedPics];
            object.arrayOfUsersPics = arrayData;
                        
            object.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
            object.phoneNumber = self.phoneTextField.text;
            object.typeOfProperty = self.objectTypeLabelInCell.text;
            object.actionByProperty = self.actionTypeLabelInCell.text;
            
            if (( self.totalSquareTextField.text.length == 0 )){
                
                object.wholeArea = @"--";
                
            }else{
                
                object.wholeArea = self.totalSquareTextField.text;
            }
            
            
            if (( self.livingSquareTextField.text.length == 0 )){
                
                 object.livingArea = @"--";
                 
             }else{
                 
                 object.livingArea = self.livingSquareTextField.text;
             }
             
             
            
             if (( self.kitchenSquareTextField.text.length == 0 )) {
                 
                 object.kitchenArea = @"--";
                 
             }else{
                 
                 object.kitchenArea = self.kitchenSquareTextField.text;
             }
             
             
            
             if ((self.objectNameTextField.text.length == 0)) {
                 
                 object.discription = @"Имя не указано";
                 
             }else{
                 
                 object.discription = self.objectNameTextField.text;
                 
             }
             
             
            if ((self.ownerNameTextField.text.length == 0)) {
                 
                 object.owner = @"Собственник не указан";
                 
             }else{
                 
                 object.owner = self.ownerNameTextField.text;
             }
             
             
            
            if ((self.adressTextfield.text.length == 0)) {
                
                object.address = @"Адрес не указан";
                
            }else{
                
                object.address = self.adressTextfield.text;
            }
            
            
            
            if ((self.priceTextField.text.length == 0)) {
                
                object.price = @"Цена не указана";
                
            }else{
                
                NSMutableString *concatString = self.priceTextField.text;
                concatString = [concatString stringByAppendingString:@" Рублей"];
                
                object.price = concatString;
                
            }
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
        }
        
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject: [UIImage imageNamed:@"emptyObject2"]];
            
        }
        
        
       /* NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myRetrievedPics];
        detailItem.arrayOfUsersPics = arrayData;*/
        
      
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject:[UIImage imageNamed:@"emptyObject2"]];
       
        }else{
            
                       
        }
        
        
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        
        
        
    
    
    } else if ([segue.identifier isEqualToString:@"unwindAndRemoveFromDetail"]) {
        
        
        [[[DataManager sharedManager] managedObjectContext] deleteObject:self.detailItem];
        
        NSError *error = nil;
        [[[DataManager sharedManager] managedObjectContext] save:&error];
        
        
        
        
    } else if ([segue.identifier isEqualToString:@"toMapView"]) {
        
      /*  AddToMapVC *mapVC = (AddToMapVC *)segue.destinationViewController;
       // mapVC.pinPhotosArray =  [[NSMutableArray alloc] init];
       // mapVC.pinPhotosArray = self.myArrayWithPhotoData;
        mapVC.detailItem = self.detailItem;
        
       
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject:[UIImage imageNamed:@"emptyObject2"]];
            
        }
        
               
        if (!self.detailItem) {
            
           
            
            NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myRetrievedPics];
            detailItem.arrayOfUsersPics = arrayData;

           
            if ((self.objectNameTextField.text.length == 0)) {
                
                detailItem.discription = @"Имя не указано";
                
            }else{
                
                detailItem.discription = self.objectNameTextField.text;
                
            }
            
           
            if ((self.priceTextField.text.length == 0)) {
                
                detailItem.price = @"Цена не указана";
                
            }else{
                
                NSMutableString *concatString = self.priceTextField.text;
                concatString = [concatString stringByAppendingString:@" Рублей"];
                
                detailItem.price = concatString;
                
            }
           
            NSError *error = nil;
            [[[DataManager sharedManager] managedObjectContext] save:&error];
            
        }*/
        
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
        
        
        self.objectTypeLabelInCell.text = [self.myData1 firstObject];
        self.actionTypeLabelInCell.text = [self.myData1 lastObject];
        
        
        [self.tableView reloadData];
        
    }
    
    NSLog(@"my array bom = %@",self.myData1);
    
}


// unwind segue from RoomType VC

- (IBAction)unwindToNewObjectVCAfterBackButtonTapped:(UIStoryboardSegue *)segue {
    
}





#pragma mark - UIImagePickerControllerDelegate



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image,0);
    
    [self.myRetrievedPics addObject:image];
    [self.myArrayWithPhotoData addObject:data];
    [self.myPhotosArray addObject:image];
    
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSString *title;
    
    if (pickerView == _roomPicker) {
        
        
        title = [_pickerViewArrayRoomQuantity objectAtIndex:row];
    }
    
    else if (pickerView == _cityPicker) {
        
        title = [_pickerViewArrayCity objectAtIndex:row];
        
    }
    
    return title;
    
}



#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
  /* if (self.myRetrievedPics.count > 1) {
        
        self.deleteButton.hidden = NO;
    }*/
   
    return self.myRetrievedPics.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CVcell";
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[CollectionViewCell alloc] init];
    }
    
    cell.objectView.image = [self.myRetrievedPics objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    return 30;
}




#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //[self showAppropriateView];
    
    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    
    if (selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        
        self.deleteButton.hidden = YES;
    }
    
    
    [self animateZoomforCell:cell];
    
}



-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    
    if (selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        
        self.deleteButton.hidden = YES;
    }
   
    
    
    [self animateZoomOutforCell:cell];
    
}


- (IBAction)deletePhotosButton:(UIButton *)sender {
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Удаление фото" message:@"Правда удалить???" preferredStyle:UIAlertControllerStyleActionSheet];
    
   
   /* NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Удаление фото"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0] range:NSMakeRange(8, 5)];
    [alert setValue:string forKey:@"attributedTitle"];

    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"Правда удалить???"];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(15, 2)];
    [alert setValue:string2 forKey:@"attributedMessage"];*/

    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Удалить" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.collectionView) {
            
            [self.collectionView performBatchUpdates:^{
                
                NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
                NSMutableIndexSet *removeIndexes = [NSMutableIndexSet new];
                
                
                for (NSIndexPath *path in selectedItemsIndexPaths) {
                    [removeIndexes addIndex:path.item];
                }
                
                if (self.myRetrievedPics.count > 0) {
                    
                    [self.collectionView reloadData];
                
                }else{
                   
                    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem: (self.myRetrievedPics.count - 1) inSection:0]]];
                }
                
                [self.myRetrievedPics removeObjectsAtIndexes:removeIndexes];
                [self.collectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
                
                
                
                NSManagedObjectContext *context = [[DataManager sharedManager] managedObjectContext];
                NSError *error = nil;
                if (![context save:&error]) {
                    
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                    
                }
                
                
            } completion:^(BOOL finished) {
                int numberOfItemsInCollection = [self.collectionView numberOfItemsInSection:0];
                if( numberOfItemsInCollection == 0 ) {
                    
                    self.deleteButton.hidden = YES;
                }
                
            }];
        }
        
    }];
    
    UIAlertAction* cancellAction = [UIAlertAction actionWithTitle:@"Отменить" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"You pressed button cancell");
    }];
    
    [alert addAction:deleteAction];
    [alert addAction:cancellAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}




#pragma mark - Helper for UICollectionView

-(void)animateZoomforCell:(CollectionViewCell*)zoomCell
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            zoomCell.transform = CGAffineTransformMakeScale(1.3,1.3);
                        } completion:^(BOOL finished){
                        }];
}


-(void)animateZoomOutforCell:(CollectionViewCell*)zoomCell
{
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            zoomCell.transform = CGAffineTransformMakeScale(1,1);
                        } completion:^(BOOL finished){
                        }];
    
}



@end
