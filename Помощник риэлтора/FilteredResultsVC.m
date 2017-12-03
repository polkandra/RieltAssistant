//
//  FilteredResultsVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "FilteredResultsVC.h"

@interface FilteredResultsVC ()

@end

@implementation FilteredResultsVC
@synthesize searchResults, tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


#pragma mark - Cell configuring

- (void)configureCell:(FilteredCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
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

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailObjectController *doc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailObjectController"];
    NSIndexPath *indexPath2 = [self.tableView indexPathForSelectedRow];
    EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath2.row];
    doc.detailItem = selectedEntity;
    [self presentViewController:doc animated:YES completion:nil];
}*/


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDOC"]) {
        DetailObjectController *doc = segue.destinationViewController;;
        NSIndexPath *indexPath2 = [self.tableView indexPathForSelectedRow];
        EstateObjectEntity *selectedEntity = [self.searchResults objectAtIndex:indexPath2.row];
        doc.detailItem = selectedEntity;
      
     //   [self controllerWhereCreateNavBar:doc titleWithSelectedEntity:selectedEntity];
       
    }
}

/*#pragma mark - Helper

-(void)controllerWhereCreateNavBar:(DetailObjectController *)controller titleWithSelectedEntity:(EstateObjectEntity *)selectedEntity {
    
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
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}  */




@end
