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
@synthesize  myPhotosArray, tableView, myArrayWithPhotoData, detailItem, hideButton, saveSecondButton, detailItemFromDetailObjectVC,  myRetrievedPics, addPlaceOnMapButton;


#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*NSInteger row = 1;
    NSInteger section = 4;
    self.expandedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];*/
    
    //NSLog(@"my array = %@",self.myData);
    
    

    self.tableView.allowsSelection = YES;
    
    [self updateUI];
    [self setDelegatesForPickerView];
    [self setDelegatesForTextFields];
    [self addGestureRecognizer];
    [self pickerViewWithData];
  
    
    [self hideShowDeleteSaveButtons];
    [self hideBackButton];
    
    [self fetchPhotos];
    
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.selectedPhotos = [[NSMutableArray alloc] init];
    self.myArrayWithPhotoData = [[NSMutableArray alloc] init];
    self.myData1 = [[NSMutableArray alloc] init];

    [self.saveSecondButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
     
    
}



-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
  /*  // Casting detailItem to EstateObjectEntity
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.myData1 = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    for (id object in _myData1) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }*/
    
  
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setNavController];
    
    NSMutableString *concatString = [self.priceTextField.text mutableCopy];
    NSRange replaceRange = [concatString rangeOfString:@"Рублей"];
    if (replaceRange.location != NSNotFound){
        NSString* result = [concatString stringByReplacingCharactersInRange:replaceRange withString:@""];
        self.priceTextField.text = result;
        }
}



#pragma mark - Helpers



-(void)setNavController {
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"BloggerSans-BoldItalic" size:21]}];
    
    if (@available(iOS 11.0, *)) {
        //self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
}


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



-(void)hideShowDeleteSaveButtons {
    
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
    
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)(detailItem.arrayOfUsersPics)];
     self.myRetrievedPics = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
   
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
        [self.detailInfoTextView setText:[self.detailItem valueForKey:@"detailInformation"]];
    }
}

- (void)setImageForButton:(UIBarButtonItem *)flipButton {
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [flipButton initWithCustomView:someButton];
}


-(void)dismissView {
    
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    if (section == 0) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Общие";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 1) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Координаты";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 2) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Параметры";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 3) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Фото объекта";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 4) {
        [headerView setBackgroundColor:[UIColor colorWithRed:184/255.0 green:197/255.0 blue:214/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Контакты";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }
    
    return headerView;
}





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
        
        
      
        
        controller.detailItem = object;
        
        object.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
        object.phoneNumber = self.phoneTextField.text;
        
        object.typeOfProperty = self.objectTypeLabelInCell.text;
        object.actionByProperty = self.actionTypeLabelInCell.text;
        object.isActive = YES;
        object.isLiked = NO;
        
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
            
            NSMutableString *concatString = [self.priceTextField.text mutableCopy];
            NSMutableString *resultString = [concatString stringByAppendingString:@" \u20BD"];
            object.price = resultString;
        }
        
        object.detailInformation = self.detailInfoTextView.text;
       
        
        
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

        
        
        
    }else if ([segue.identifier isEqualToString:@"unwindAndSaveToDetail"]) {
        
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
           
            NSMutableString *concatString = [self.priceTextField.text mutableCopy];
            
            if ([concatString rangeOfString:@"\u20BD"].location == NSNotFound) {
              
                NSMutableString *resultString = [concatString stringByAppendingString:@" \u20BD"];
                detailItem.price = resultString;
            } else {
                detailItem.price = concatString;
            }
            
//            NSMutableString *resultString = [concatString stringByAppendingString:@" \u20BD"];
//            detailItem.price = resultString;
            
            // detailItem.price = self.priceTextField.text;
            detailItem.phoneNumber = self.phoneTextField.text;
            detailItem.typeOfProperty = self.objectTypeLabelInCell.text;
            detailItem.actionByProperty = self.actionTypeLabelInCell.text;
            detailItem.wholeArea = self.totalSquareTextField.text;
            detailItem.livingArea = self.livingSquareTextField.text;
            detailItem.kitchenArea = self.kitchenSquareTextField.text;
            detailItem.roomQuantity = [self.pickerViewArrayRoomQuantity objectAtIndex:[_roomPicker selectedRowInComponent:0]];
            detailItem.detailInformation = self.detailInfoTextView.text;
            
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
            
            if (self.totalSquareTextField.text.length == 0 ) {
                
                object.wholeArea = @"--";
                
            }else{
                
                object.wholeArea = self.totalSquareTextField.text;
            }
            
            
            if (self.livingSquareTextField.text.length == 0 ){
                
                 object.livingArea = @"--";
                 
             }else{
                 
                 object.livingArea = self.livingSquareTextField.text;
             }
            
            
             if (self.kitchenSquareTextField.text.length == 0) {
                 
                 object.kitchenArea = @"--";
                 
             }else{
                 
                 object.kitchenArea = self.kitchenSquareTextField.text;
             }
            
            
             if (self.objectNameTextField.text.length == 0) {
                 
                 object.discription = @"Имя не указано";
                 
             }else{
                 
                 object.discription = self.objectNameTextField.text;
                 
             }
             
             
            if (self.ownerNameTextField.text.length == 0) {
                 
                 object.owner = @"Собственник не указан";
                 
             }else{
                 
                 object.owner = self.ownerNameTextField.text;
             }
            
            
            if (self.adressTextfield.text.length == 0) {
                
                object.address = @"Адрес не указан";
                
            }else{
                
                object.address = self.adressTextfield.text;
            }
            
            
             object.detailInformation = self.detailInfoTextView.text;
           
            
            if (self.priceTextField.text.length == 0) {
                
                object.price = @"Цена не указана";
                
            }else{
                
                NSMutableString *concatString = [self.priceTextField.text mutableCopy];
                
                if ([concatString rangeOfString:@"\u20BD"].location == NSNotFound) {
                    
                    NSMutableString *resultString = [concatString stringByAppendingString:@" \u20BD"];
                    object.price = resultString;
                }else{
                    object.price = concatString;
                }
                
            }
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
        }
        
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject: [UIImage imageNamed:@"emptyObject2"]];
            
        }
        
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myRetrievedPics];
        detailItem.arrayOfUsersPics = arrayData;
        
        
        
        if (self.myRetrievedPics.count == 0) {
            
            [self.myRetrievedPics addObject:[UIImage imageNamed:@"emptyObject2"]];
            
            
            [[[DataManager sharedManager] managedObjectContext] save:nil];
            
        }
        
        
    }else if ([segue.identifier isEqualToString:@"unwindAndRemoveFromDetail"]) {
        
        
        [[[DataManager sharedManager] managedObjectContext] deleteObject:self.detailItem];
        
        NSError *error = nil;
        [[[DataManager sharedManager] managedObjectContext] save:&error];
        
        
        
    }else if ([segue.identifier isEqualToString:@"toAddPhotosController"]) {
        
        AddPhotosVC *apVC = (AddPhotosVC *)segue.destinationViewController;
        apVC.detailItem = self.detailItem;
      
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
        
        [self setImageForButton:flipButton];
        
        apVC.navigationItem.leftBarButtonItem = flipButton;
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
        
        RoomTypeController *controller = (RoomTypeController *)segue.sourceViewController;
        
        
        self.objectTypeLabelInCell.text = [self.myData1 firstObject];
        self.actionTypeLabelInCell.text = [self.myData1 lastObject];
        
        
        [self.tableView reloadData];
        
    }
    
    NSLog(@"my array bom = %@",self.myData1);
    
}


// unwind segue from RoomType VC

- (IBAction)unwindToNewObjectVCAfterBackButtonTapped:(UIStoryboardSegue *)segue {
    
}


// unwind segue from AddPhotosVC

- (IBAction)unwindFromAddPhotosVC:(UIStoryboardSegue *)segue {
    
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
    
   // self.myPhotosArray = [[NSMutableArray alloc] init];
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
   
    }else {
        quantity = [_pickerViewArrayCity count];
        
    }
    return quantity;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title;
    
    if (pickerView == _roomPicker) {
        
        title = [_pickerViewArrayRoomQuantity objectAtIndex:row];
        
    }else if (pickerView == _cityPicker) {
        
        title = [_pickerViewArrayCity objectAtIndex:row];
    }
    return title;
}





@end
