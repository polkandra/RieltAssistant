//
//  AddPhotosVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "AddPhotosVC.h"

@interface AddPhotosVC ()

@end

@implementation AddPhotosVC
@synthesize myRetrievedPics, detailItem, collectionView, myPhotosArray;


#pragma mark - VC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.allowsMultipleSelection = YES;
    
    [self showHideDeleteButton];
    [self fetchPhotos];
    
    
    self.myPhotosArray = [[NSMutableArray alloc] init];
    self.myArrayWithPhotoData = [[NSMutableArray alloc] init];

}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // [self fetchPhotos];
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //  [self.navigationItem setTitle:@"Новый объект"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"BloggerSans-BoldItalic" size:21]}];
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
    
    /*[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     self.navigationController.navigationBar.translucent = YES;*/
    
    // self.globalArrayOfUsersPics = [[NSMutableArray alloc] init];
    
  
}




-(void)fetchPhotos {
    
   /* NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.arrayWithEntities = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    for (id object in self.arrayWithEntities) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }*/
    
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)(detailItem.arrayOfUsersPics)];
    self.myRetrievedPics = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
    
    if ([self.myRetrievedPics containsObject:[UIImage imageNamed:@"emptyObject2"]]) {
        [self.myRetrievedPics removeObject:[UIImage imageNamed:@"emptyObject2"]];
    }
    
}


- (void) showHideDeleteButton {
    
    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    
    if (selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        self.deleteButton.hidden = YES;
    }
}






#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    /* if (self.myRetrievedPics.count > 1) {
     
     self.deleteButton.hidden = NO;
     }*/
    
    
    
    return self.myRetrievedPics.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const reuseIdentifier = @"collectionCell";
    
    AddPhotoCVCell *cell = (AddPhotoCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[AddPhotoCVCell alloc] init];
    }
    
    
    cell.cellPicture.image = [self.myRetrievedPics objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
}




#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AddPhotoCVCell *cell = (AddPhotoCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
   
    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    
    if (selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        
        self.deleteButton.hidden = YES;
    }
    
    [self animateZoomforCell:cell];
    
}



-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AddPhotoCVCell *cell = (AddPhotoCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
    
    if (selectedItemsIndexPaths.count > 0) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        
        self.deleteButton.hidden = YES;
    }
    
    [self animateZoomOutforCell:cell];
    
}



#pragma mark - Helper for UICollectionView

-(void)animateZoomforCell:(AddPhotoCVCell *)zoomCell {

    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            zoomCell.transform = CGAffineTransformMakeScale(1.3,1.3);
                        } completion:^(BOOL finished){
                        }];
}


-(void)animateZoomOutforCell:(AddPhotoCVCell *)zoomCell {

    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            zoomCell.transform = CGAffineTransformMakeScale(1,1);
                        } completion:^(BOOL finished){
                        }];
    
}



#pragma mark - UIImagePickerControllerDelegate



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image,0);
    
    
    [self.myRetrievedPics addObject:image];
    [self.myPhotosArray addObject:image];
    [self.myArrayWithPhotoData addObject:data];
    
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Actions

- (IBAction)addPics:(UIButton *)sender {

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

- (IBAction)deletePics:(UIButton *)sender {

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
             
                NSArray* selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
                if (selectedItemsIndexPaths.count == 0 ) {
                    
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


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"unwindFromAddPhotosVC"]) {
       
        NewObjectViewController *noVC = (NewObjectViewController *)segue.destinationViewController;

//        noVC.myArrayWithPhotoData = [[NSMutableArray alloc] init];
//        noVC.myPhotosArray = [[NSMutableArray alloc] init];
        
        noVC.myArrayWithPhotoData = self.myArrayWithPhotoData;
        noVC.myPhotosArray = self.myPhotosArray;
        noVC.myRetrievedPics = self.myRetrievedPics;
        
       // self.detailItem = noVC.detailItem;
        
        
//        if (self.myArrayWithPhotoData.count == 0) {
//
//            UIImage *image = [UIImage imageNamed:@"emptyObject2"];
//            NSData* pictureData = UIImageJPEGRepresentation(image,0);
//
//            [self.myArrayWithPhotoData addObject:pictureData];
//            [self.myPhotosArray addObject:image];
//
//
//
//            detailItem.picture = [self.myArrayWithPhotoData firstObject];
//
//        }else{
//
//            detailItem.picture = [self.myArrayWithPhotoData firstObject];
//
//        }
//
//
//        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:self.myPhotosArray];
//        detailItem.arrayOfUsersPics = arrayData;
//
//
//
//        [[[DataManager sharedManager] managedObjectContext] save:nil];

    
    }
  
}


@end
