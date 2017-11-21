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

- (void)viewDidLoad {
    [super viewDidLoad];
  
        // self.view.backgroundColor = [StyleKitName drawBackgroundColor];
    
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
        
        // create new nav controller
        UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"Object"];

       // DetailObjectController *controller = (DetailObjectController *)navController.topViewController;
        DetailObjectController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailObjectController"];;
        // pass search result
        NSIndexPath *indexPath2 = [self.tableView indexPathForSelectedRow];
        EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath2.row];
        controller.detailItem = selectedEntity;
       
       
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
       
        
        
//        UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        navBar.backgroundColor = [UIColor clearColor];
//        [controller.view addSubview:navBar];
        UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Navigation Title"];
        navigItem.rightBarButtonItem = flipButton;
        
        
        //controller.navigationItem.rightBarButtonItem = flipButton;
       // [self.presentingViewController.navigationController pushViewController:controller animated:YES];
        // present view controller via navigation controller
        [self presentViewController:navController animated:YES completion:nil];
        //[self.navigationController pushViewController:controller animated:YES];
        //[self.navigationController pushViewController:controller animated:YES];
        //[self performSegueWithIdentifier:@"fromSearchResultToDetail" sender:tableView];
    
    }


#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // extract array from observer
    self.searchResults = [(NSMutableArray *)object valueForKey:@"entities"];
    MainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainStoryboardID"];
    mainVC.detailItem = self.detailItem;
    [self.tableView reloadData];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
  /* if ([segue.identifier isEqualToString:@"fromSearchResultToDetail"]) {
       
       DetailObjectController *doc = segue.destinationViewController;
       NSIndexPath *indexPath2 = [self.tableView indexPathForSelectedRow];
       EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath2.row];
       doc.detailItem = selectedEntity;
       
       UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
       
       doc.navigationItem.rightBarButtonItem = flipButton;
       
       
   }else if ([segue.identifier isEqualToString:@"toSearchResults"]) {
       
       
       
   }*/
    
}



-(void)dismissView {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
