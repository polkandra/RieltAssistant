//
//  NewObjectViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 27.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "NewObjectViewController.h"


@interface NewObjectViewController ()

//@property(assign, nonatomic) BOOL isSelected;

@end

@implementation NewObjectViewController
@synthesize  myPhotosArray, tableView, myArrayWithPhotoData, detailItem, hideButton, saveSecondButton, detailItemFromDetailObjectVC, fetchedResultsController, managedObjectContext;


#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*NSInteger row = 1;
    NSInteger section = 4;
    self.expandedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];*/
    
    //NSLog(@"my array = %@",self.myData);
    
    
   // self.itemChanges = [NSMutableArray array];
  //  self.sectionChanges = [NSMutableArray array];
    
   
   
    if (self.hideButton == YES) {
        
        self.saveSecondButton.hidden = YES;
    
    }else{
      
        self.saveSecondButton.hidden = NO;
    }
    
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsMultipleSelection = YES;
    self.tableView.allowsSelection = YES;
    
    [self updateUI];
    [self setDelegatesForPickerView];
    [self setDelegatesForTextFields];
    [self addGestureRecognizer];
    [self pickerViewWithData];
    
    self.myData = [[NSMutableArray alloc] init];
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];
    self.myArrayWithPhotoData = [[NSMutableArray alloc] init];
    self.arrayForPVC = [[NSMutableArray alloc] init];
   
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
            
            NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems];
           
            NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
            
            NSMutableIndexSet *removeIndexes = [NSMutableIndexSet new];
           
           // EstateObjectEntity *obj = [selectedItemsIndexPaths objectAtIndex:indexPath.item];
            
            
            
            for (NSIndexPath *path in selectedItemsIndexPaths) {
                [removeIndexes addIndex:path.item];
                
            }
           
           
            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
            [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
                
            }

            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
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
        
        
        MainViewController *controller = (MainViewController *)segue.destinationViewController;
        
        // controller.myPhotosData = [[NSMutableArray alloc] init];
        //controller.myPhotosData = self.myPhotosArray;
        
        
        EstateObjectEntity* object =
        [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity"
                                      inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
        
        
        // controller.myPhotosData = self.myArrayWithPhotoData;
        
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
        
       
        if ([self.myArrayWithPhotoData count] == 0) {
            
            UIImage *image = [UIImage imageNamed:@"emptyObject2"];
            
                NSData* pictureData = UIImageJPEGRepresentation(image,0);
            
                [self.myArrayWithPhotoData addObject:pictureData];
                [self.myPhotosArray addObject:image];
                
                object.picture = [self.myArrayWithPhotoData firstObject];
                // object.picture = [self.arrayForPVC firstObject];
                // [object setValue:[self.myArrayWithPhotoData firstObject] forKey:@"picture"];
                
            }else{
                
                object.picture = [self.myArrayWithPhotoData firstObject];
                // object.picture = [self.arrayForPVC firstObject];
                // [object setValue:[self.myArrayWithPhotoData firstObject] forKey:@"picture"];
                
            }
        
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myPhotosArray];
        object.arrayOfUsersPics = arrayData;
        
       [[[DataManager sharedManager] managedObjectContext] save:nil];
    
    
        
    } else if ([segue.identifier isEqualToString:@"unwindAndSaveToDetail"]) {
        
        
        
        if (self.detailItem) {
            
            // UPDATING EXISTING OBJECTS.
            
            self.detailItem.discription = self.objectNameTextField.text;
            self.detailItem.address = self.adressTextfield.text;
            self.detailItem.owner = self.ownerNameTextField.text;
            self.detailItem.price = self.priceTextField.text;
            self.detailItem.phoneNumber = self.phoneTextField.text;
            self.detailItem.typeOfProperty = self.objectTypeLabelInCell.text;
            self.detailItem.actionByProperty = self.actionTypeLabelInCell.text;
            self.detailItem.wholeArea = self.totalSquareTextField.text;
            self.detailItem.livingArea = self.livingSquareTextField.text;
            self.detailItem.kitchenArea = self.kitchenSquareTextField.text;
            self.detailItem.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
            
            
        }else{
            
            // CREATING A NEW OBJECT.
            
            EstateObjectEntity* object =
            [NSEntityDescription insertNewObjectForEntityForName:@"EstateObjectEntity"
                                           inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
             
          
            
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
             
             if ([self.myArrayWithPhotoData count] == 0) {
                 
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
             
         }
         
         [[[DataManager sharedManager] managedObjectContext] save:nil];
        
    
         
         
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





/*
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

*/



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





- (NSManagedObjectContext*) managedObjectContext {
    
    if (!managedObjectContext) {
        managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    }
    return managedObjectContext;
}



- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EstateObjectEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *picture = [[NSSortDescriptor alloc] initWithKey:@"picture" ascending:YES];
    NSArray *sortDescriptors = @[picture];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
       
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}



#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CVcell";
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[CollectionViewCell alloc] init];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)configureCell:(CollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EstateObjectEntity *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.objectView.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];
    
  }




#pragma mark - FetchedResultsControllerDelegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    self.shouldReloadCollectionView = NO;
    self.blockOperation = [[NSBlockOperation alloc] init];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    __weak UICollectionView *collectionView = self.collectionView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    __weak UICollectionView *collectionView = self.collectionView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            if ([self.collectionView numberOfSections] > 0) {
                if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                    self.shouldReloadCollectionView = YES;
                } else {
                    [self.blockOperation addExecutionBlock:^{
                        [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
                    }];
                }
            } else {
                self.shouldReloadCollectionView = YES;
            }
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                self.shouldReloadCollectionView = YES;
            } else {
                [self.blockOperation addExecutionBlock:^{
                    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
                }];
            }
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [self.blockOperation addExecutionBlock:^{
                [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            }];
            break;
        }
            
        default:
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    if (self.shouldReloadCollectionView) {
        [self.collectionView reloadData];
    } else {
        [self.collectionView performBatchUpdates:^{
            [self.blockOperation start];
        } completion:nil];
    }
}



/*- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    _sectionChanges = [[NSMutableArray alloc] init];
    _itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    change[@(type)] = @(sectionIndex);
    [_sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
   
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in _sectionChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        case NSFetchedResultsChangeMove:
                        NSLog(@"A collection item was moved");
                        break;
                    case NSFetchedResultsChangeUpdate:
                        NSLog(@"A collection item was updated");
                        break;
                }
            }];
        }
        for (NSDictionary *change in _itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        _sectionChanges = nil;
        _itemChanges = nil;
    }];
}*/




@end
