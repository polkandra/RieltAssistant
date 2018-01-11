//
//  SearchResultsTableViewController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 20.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "SearchResultsTableViewController.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController
@synthesize detailItem, nc, top;


#pragma mark - VC lificycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
   
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
//    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:@"Object" bundle:nil];
//    self.top = [storyboard instantiateViewControllerWithIdentifier:@"Object88"];
//    self.top = [UIApplication sharedApplication].keyWindow.rootViewController;
//    self.top = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    [(AppDelegate*)[[UIApplication sharedApplication]delegate] switchNavController];
//    self.top = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [self.top setNavigationBarHidden:YES animated:NO];
    

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SearchResultCell";
    
    FilteredResultCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Cell configuring

- (void)configureCell:(FilteredResultCellTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    EstateObjectEntity *object = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.nameCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"discription"]];
    cell.nameCellLabel.textColor = [UIColor whiteColor];
    cell.priceCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"price"]];
    cell.priceCellLabel.textColor = [UIColor whiteColor];
    cell.addressCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"address"]];
    cell.addressCellLabel.textColor = [UIColor whiteColor];
    cell.ownerCellLabel.text = [NSString stringWithFormat:@"%@",[object valueForKey:@"owner"]];
    cell.ownerCellLabel.textColor = [UIColor whiteColor];
    
    cell.imageViewCell.image = [[UIImage alloc] initWithData:[object valueForKey:@"picture"]];
    cell.backgroundColor = [UIColor clearColor];
    
    if (object.isLiked == YES) {
        
        cell.likeView.image = [UIImage imageNamed:@"likeRed"];
        
    }else{
        
        cell.likeView.image = nil;
    }
    
    if (object.isActive == YES) {
        
        cell.activeView.image = [UIImage imageNamed:@"active"];
        
    }else{
        
        cell.activeView.image = [UIImage imageNamed:@"finished"];
    }
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard  *storyboard = [UIStoryboard storyboardWithName:@"Object" bundle:nil];
    DetailObjectController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DetailObjectController"];
    // NSIndexPath *indexPath2 = [tableView indexPathForSelectedRow];
    EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath.row];
    controller.detailItem = selectedEntity;
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    [self setImageForButton:flipButton];
    
    controller.navigationItem.leftBarButtonItem = flipButton;
    controller.navigationItem.rightBarButtonItem = nil;
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [(AppDelegate*)[[UIApplication sharedApplication]delegate] switchNavController];
    
    self.top = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [self.top pushViewController:controller animated:YES];
    
}



#pragma mark - Navigation


/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"fromSearchToDetail"]) {
        
        DetailObjectController *doc = (DetailObjectController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath.row];
        doc.detailItem = selectedEntity;
        doc.goToMap.userInteractionEnabled = NO;
        doc.goToMap.hidden = YES;
        //  [self controllerWhereCreateNavBar:doc titleWithSelectedEntity:selectedEntity];
    }
    
}*/


#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // extract array from observer
    self.searchResults = [(NSMutableArray *)object valueForKey:@"entities"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Object" bundle:nil];
    MainViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainStoryboardID"];
    mainVC.detailItem = self.detailItem;
    [self.tableView reloadData];
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
  
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [(AppDelegate*)[[UIApplication sharedApplication]delegate] switchNavControllerToTabBar];

}




@end
