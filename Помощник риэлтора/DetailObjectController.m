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
@synthesize tableView,  myDetailPhotosArray, detailItem, detailItem2, telString, documentInteractionController;


#pragma mark - VC Lifecycle


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self configureView];
    [self setNavController];
    
    //[self setNavController];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
    
   
}



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.fetchedObjects = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.sourceArray = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
}



#pragma mark - Helpers

-(void)configureView {
    
    if (self.detailItem) {
        
        self.title = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
        
        self.detailPriceLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"price"]];
        self.detailAddressLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"address"]];
        self.detailOwnerLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"owner"]];
        self.detailRoomLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"roomQuantity"]];
        self.detailWholeSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"wholeArea"]];
        self.detailLivingSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"livingArea"]];
        self.detailKitchenSquareLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"kitchenArea"]];
        self.phoneNumberLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"phoneNumber"]];
        self.actionLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"typeOfProperty"]];
        self.typeLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"actionByProperty"]];
        self.detailInfoLabel.text = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"detailInformation"]];
        
        if (self.detailItem.isActive == NO) {
            UIImage *pressedbuttonImage1 = [UIImage imageNamed:@"finished"];
            [self.statusButton setImage:pressedbuttonImage1 forState:UIControlStateNormal];
        }else{
            UIImage *pressedbuttonImage2 = [UIImage imageNamed:@"active"];
            [self.statusButton setImage:pressedbuttonImage2 forState:UIControlStateNormal];
        }
    
        
        if (self.detailItem.isLiked == NO) {
            UIImage *pressedbuttonImage1 = [UIImage imageNamed:@"like"];
            [self.likeButton setImage:pressedbuttonImage1 forState:UIControlStateNormal];
        }else{
            UIImage *pressedbuttonImage2 = [UIImage imageNamed:@"likeRed"];
            [self.likeButton setImage:pressedbuttonImage2 forState:UIControlStateNormal];
        }
        
    }
}


-(void)setNavController {

 [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
 [self.navigationController.navigationBar setTranslucent:NO];
 
 //  [self.navigationItem setTitle:@"Новый объект"];
 
 [self.navigationController.navigationBar
 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
 
 [self.navigationController.navigationBar setTitleTextAttributes:
 @{NSForegroundColorAttributeName:[UIColor whiteColor],
 NSFontAttributeName:[UIFont fontWithName:@"BloggerSans-BoldItalic" size:21]}];
 
 if (@available(iOS 11.0, *)) {
 self.navigationController.navigationBar.prefersLargeTitles = NO;
 } else {
 // Fallback on earlier versions
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




#pragma mark - Segues

// unwind segue from AddToMapVC with saving
- (IBAction)saveFromAddToMapVC:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"saveFromAddToMapVC"]) {
       
       // [self.goToMap setTitle:[NSString stringWithFormat:@"%@",[detailItem valueForKey:@"address"]] forState:UIControlStateNormal ];
    
    }
    
}



// unwind segue from NewObjectVC with saving
- (IBAction)saveSecondButtonTaped:(UIStoryboardSegue*)segue {
    
   
    
    if ([segue.identifier isEqualToString:@"unwindAndSaveToDetail"]) {
        
        NSMutableArray *arrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
        self.sourceArray = [[NSMutableArray alloc] initWithArray:arrayWithUsersPics];
    
        [self configureView];
        
    }
}


// unwind segue from NewObjectVC with canceling
- (IBAction)cancelFromNewObjectButtonTaped:(UIStoryboardSegue*)segue {
    
    if ([segue.identifier isEqualToString:@"cancelFromNewObjectButtonTaped"]) {
              
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toPage"]) {
        
        UIPageViewControllerScene *controller = (UIPageViewControllerScene *)segue.destinationViewController;
        controller.detailItem = self.detailItem;
        
                    
    }else if ([segue.identifier isEqualToString:@"editFromDetailVC"]) {
                
        NewObjectViewController *newVC = (NewObjectViewController *)segue.destinationViewController;
        newVC.detailItem = self.detailItem;
        newVC.navigationItem.title = [NSString stringWithFormat:@"%@",[detailItem valueForKey:@"discription"]];
        newVC.navigationItem.rightBarButtonItem = nil;
        newVC.saveSecondButton.hidden = NO;
        newVC.hideButton = NO;
    
    
    }else if ([segue.identifier isEqualToString:@"unwindAfterBackButtonFromDetail"]) {
        
        NSData* pictureData = UIImageJPEGRepresentation([self.sourceArray firstObject],0);
        detailItem.picture = pictureData;
        
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
    
    } else if ([segue.identifier isEqualToString:@"toMapView"]) {
        
        AddToMapVC *mapVC = (AddToMapVC *)segue.destinationViewController;
        mapVC.detailItem = self.detailItem;
        mapVC.pinPhotosArray = self.sourceArray;
    }
   
}



#pragma mark - Actions



- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {
    
    NewObjectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"New"];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    
    [self setImageForButton:flipButton];
    
    controller.title = [NSString stringWithFormat:@"%@", [self.detailItem valueForKey:@"discription"]];
    controller.navigationController.navigationItem.leftBarButtonItem = flipButton;
   
    controller.detailItem = self.detailItem;
    [self.navigationController pushViewController:controller animated:YES];

}


- (IBAction)addPlaceToMapButton:(UIButton *)sender {
    
   // AddToMapVC *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddToMapVC"];
   // mapVC.detailItem = self.detailItem;
  
}



- (IBAction)callButton:(UIButton *)sender {
    
    if (self.phoneNumberLabel.text.length > 0) {
        self.telString = [@"telprompt://" stringByAppendingString:self.phoneNumberLabel.text];
    }else{
        return;
    }
    
    NSURL *url = [NSURL URLWithString:telString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
    }
}


- (IBAction)shareButtonTapped:(UIBarButtonItem *)sender {
    
    NSArray *activities = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypeOpenInIBooks,UIActivityTypeMarkupAsPDF];
    
    NSArray *items = @[[self.sourceArray firstObject]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityViewController.excludedActivityTypes = activities;
    
    /* NSString * msg = @"YOUR MSG";
     NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
     NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
     [[UIApplication sharedApplication] openURL:whatsappURL options:@{} completionHandler:nil];
     } else {
     // Cannot open whatsapp
     }*/
    
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
        
        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.jpg"];
        
        [UIImageJPEGRepresentation([self.sourceArray firstObject], 1.0) writeToFile:savePath atomically:YES];
        
        documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        documentInteractionController.UTI = @"net.whatsapp.image";
        documentInteractionController.delegate = self;
        [documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"No WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    [self presentViewController:activityViewController animated:YES completion:NULL];
}



- (IBAction)likeButtonTapped:(UIButton *)sender {
    
//    UIImage *pressedbuttonImage = [UIImage imageNamed:@"like"];
//    UIImage *pressedbuttonImage2 = [UIImage imageNamed:@"likeRed"];
//    [self.likeButton setBackgroundImage:pressedbuttonImage forState:UIControlStateNormal];
//    [self.likeButton setBackgroundImage:pressedbuttonImage2 forState:UIControlStateSelected];
    sender.selected = !sender.selected;
    
    if (self.likeButton.isSelected) {
        if (self.detailItem.isLiked == YES) {
            UIImage *pressedbuttonImage = [UIImage imageNamed:@"like"];
            [self.likeButton setImage:pressedbuttonImage forState:UIControlStateNormal];
            self.detailItem.isLiked = NO;
        }else{
            UIImage *pressedbuttonImage2 = [UIImage imageNamed:@"likeRed"];
            [self.likeButton setImage:pressedbuttonImage2 forState:UIControlStateSelected];
            self.detailItem.isLiked = YES;
        }
        [[[DataManager sharedManager] managedObjectContext] save:nil];
    }
}



- (IBAction)statusButtonTapped:(UIButton *)sender {
   
    sender.selected = !sender.selected;
    
    if (self.statusButton.isSelected ) {
        if (self.detailItem.isActive == YES) {
            UIImage *pressedbuttonImage = [UIImage imageNamed:@"finished"];
            [self.statusButton setImage:pressedbuttonImage forState:UIControlStateNormal];
            self.detailItem.isActive = NO;
            
        }else{
            UIImage *pressedbuttonImage2 = [UIImage imageNamed:@"active"];
            [self.statusButton setImage:pressedbuttonImage2 forState:UIControlStateSelected];
            self.detailItem.isActive = YES;
            
        }
        
        [[[DataManager sharedManager] managedObjectContext] save:nil];
        
    }
}

@end
