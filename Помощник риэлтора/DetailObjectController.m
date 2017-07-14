//
//  DetailObjectController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 23.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "DetailObjectController.h"

@interface DetailObjectController ()

@end

@implementation DetailObjectController
@synthesize tableView,  myDetailPhotosArray, myDetailData, detailItem, fetchedResultsController;


- (void)viewDidLoad {
   
    
    [super viewDidLoad];
    
    
    //self.myDetailPhotosArray = [[NSMutableArray alloc] init];
    
    self.myDetailData = [[NSMutableArray alloc] init];
    
    
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"EstateObjectEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError*error = nil;
    
    _fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    EstateObjectEntity *object = [_fetchedObjects objectAtIndex:indexPath.row];*/
    
    
   // self.detailItem = [[EstateObjectEntity alloc]initWithEntity:@"EstateObjectEntity" insertIntoManagedObjectContext:self.managedObjectContext ];
    
    
   /* if (self.detailItem) {
    
    self.detailPriceLabel.text = detailItem.price;
    self.detailAddressLabel.text = detailItem.address;
    self.detailOwnerLabel.text = detailItem.owner;
    self.detailRoomLabel.text = detailItem.roomQuantity;
    self.detailWholeSquareLabel.text = detailItem.wholeArea;
    self.detailLivingSquareLabel.text = detailItem.livingArea;
    self.detailKitchenSquareLabel.text = detailItem.kitchenArea;
    self.phoneNumberLabel.text = detailItem.phoneNumber;
    self.actionLabel.text = detailItem.actionByProperty;
    self.typeLabel.text = detailItem.typeOfProperty;
    
    }*/
    
    
    if (self.detailItem) {
        
        self.detailPriceLabel.text = [detailItem valueForKey:@"price"];
        self.detailAddressLabel.text = [detailItem valueForKey:@"address"];
        self.detailOwnerLabel.text = [detailItem valueForKey:@"owner"];
        self.detailRoomLabel.text = [detailItem valueForKey:@"roomQuantity"];
        self.detailWholeSquareLabel.text = [detailItem valueForKey:@"wholeArea"];
        self.detailLivingSquareLabel.text = [detailItem valueForKey:@"livingArea"];
        self.detailKitchenSquareLabel.text = [detailItem valueForKey:@"kitchenArea"];
        self.phoneNumberLabel.text = [detailItem valueForKey:@"phoneNumber"];
        self.actionLabel.text = [detailItem valueForKey:@"typeOfProperty"];
        self.typeLabel.text = [detailItem valueForKey:@"actionByProperty"];
    
    }
    
    /* self.detailPriceLabel.text = myDetailObject.price;
    self.detailAddressLabel.text = myDetailObject.address;
    self.detailOwnerLabel.text = myDetailObject.owner;
    self.detailRoomLabel.text = myDetailObject.roomQuantity;
    self.detailWholeSquareLabel.text = myDetailObject.wholeArea;
    self.detailLivingSquareLabel.text = myDetailObject.livingArea;
    self.detailKitchenSquareLabel.text = myDetailObject.kitchenArea;
    self.phoneNumberLabel.text = myDetailObject.phoneNumber;
    self.actionLabel.text = myDetailObject.typeOfProperty;
    self.typeLabel.text = myDetailObject.actionByProperty;*/
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
        
        NSLog(@"transfered pics == %@",self.myDetailPhotosArray);
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (IBAction)detailMapAddressButton:(id)sender {
    
    
}



- (IBAction)callButton:(UIButton *)sender {






}



/*- (IBAction)backBarButtonItem:(UIBarButtonItem *)sender {
    

}

- (IBAction)changeDetailItemBurButtonItem:(UIBarButtonItem *)sender {
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  [self.myDetailPhotosArray count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"detailCollectionViewCell";
    
    DetailCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    if ([self.myDetailPhotosArray containsObject:@"emptyObject2"]) {
        cell.detailImageView.image = nil;
        
    }else{
        
        cell.detailImageView.image = [self.myDetailPhotosArray objectAtIndex:indexPath.row];
    }
    
    return cell;
    
    
}*/

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toPage"]) {
        
        UIPageViewControllerScene *controller = (UIPageViewControllerScene *)segue.destinationViewController;
        
        controller.pageVCArray = [[NSMutableArray alloc]init];
        controller.pageVCArray = self.myDetailPhotosArray;
        
        
        
    }else if ([segue.identifier isEqualToString:@"backToNew"]) {
        
        NewObjectViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"New"];
        
        
        [self presentViewController:newVC animated:YES completion:nil];
    }
    
}



-(NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}



#pragma mark -- NSFetchedResultsController


- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EstateObjectEntity"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:10];
    
    NSSortDescriptor *discription = [[NSSortDescriptor alloc] initWithKey:@"discription" ascending:YES];
    NSSortDescriptor *price = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    NSArray *sortDescriptors = @[discription, price];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
   
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    //    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    //    [NSFetchedResultsController load];
    
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


@end
