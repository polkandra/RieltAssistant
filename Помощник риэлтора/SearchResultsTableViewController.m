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
@synthesize detailItem, srTVC, nc;


#pragma mark - VC lificycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    srTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
   
    
     self.nc = [[UINavigationController alloc] initWithRootViewController:self];


}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

     return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SearchResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    
}

#pragma mark - UITableViewDelegate



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.top = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
    DetailObjectController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailObjectController"];
    NSIndexPath *indexPath2 = [self.tableView indexPathForSelectedRow];
    EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath2.row];
    controller.detailItem = selectedEntity;
    controller.goToMap.userInteractionEnabled = NO;
    controller.goToMap.hidden = YES;
    
    
    [self controllerWhereCreateNavBar:controller titleWithSelectedEntity:selectedEntity];
    
    [self.top presentViewController:controller animated:YES completion: nil];
}


#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // extract array from observer
    self.searchResults = [(NSMutableArray *)object valueForKey:@"entities"];
    MainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainStoryboardID"];
    mainVC.detailItem = self.detailItem;
    [self.tableView reloadData];
}



#pragma mark - Helper

- (void)controllerWhereCreateNavBar:(DetailObjectController *)controller titleWithSelectedEntity:(EstateObjectEntity *)selectedEntity {
   
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
   
    navBar.backgroundColor = [StyleKitName gradientColor52];
   
        [navBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    [navBar setTranslucent:YES];
   
    [controller.view addSubview:navBar];
    
    NSString * myTitle = [NSString stringWithFormat:@"%@",[selectedEntity valueForKey:@"discription"]];
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:myTitle];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    
    [flipButton initWithCustomView:someButton];
    
    navigItem.leftBarButtonItem = flipButton;
    navBar.items = @[navigItem];
}




-(void)dismissView {
    
    [self.top dismissViewControllerAnimated:YES completion:nil];
   

}

@end
