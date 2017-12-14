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
    
    FilteredCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    
    if (object.isLiked == YES) {
        
        cell.likeView.image = [UIImage imageNamed:@"likeRed"];
        
    }else{
        
        cell.likeView.image = nil;
    }
    
    if (object.isActive == YES) {
        
        cell.statusView.image = [UIImage imageNamed:@"active"];
        
    }else{
        
        cell.statusView.image = [UIImage imageNamed:@"finished"];
    }
    
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



@end
