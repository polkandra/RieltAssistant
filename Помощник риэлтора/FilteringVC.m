//
//  FilteringVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "FilteringVC.h"

@interface FilteringVC ()
@end


@implementation FilteringVC
@synthesize cellSelectedArray, tableView, segmentedControl, entities, filteredResults;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellSelectedArray = [[NSMutableArray alloc] init];
    
 /*   FilteredResultsVC *resultsVC = (FilteredResultsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"ResultsTableViewController"];;
   
    [self addObserver:resultsVC forKeyPath:@"entities" options:NSKeyValueObservingOptionNew context:nil];*/
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
   
    
}




#pragma mark - Actions

- (IBAction)startSearch:(UIBarButtonItem *)sender{

   



}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    if (section == 0) {
        [headerView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:119/255.0 blue:62/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"Количество комнат";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 1) {
        [headerView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:119/255.0 blue:62/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"По типу действия";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }else if (section == 2) {
        [headerView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:119/255.0 blue:62/255.0 alpha:1]];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 42)];
        titleLabel.text = @"По типу объекта";
        titleLabel.font = [UIFont fontWithName:@"BloggerSans-BoldItalic" size:18];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [headerView addSubview:titleLabel];
    }
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self tableViewWithIndexPath:indexPath tableView:tableView];
    
  //  NSIndexPath *selectedCell = [tableView indexPathForSelectedRow];
    
  
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    NSMutableArray *selectedArray = [self.tableView indexPathsForSelectedRows];
    
    NSIndexPath *row1 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *row2 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *row3 = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *row4 = [NSIndexPath indexPathForRow:1 inSection:2];
    NSIndexPath *row5 = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *row6 = [NSIndexPath indexPathForRow:3 inSection:2];
    NSIndexPath *row7 = [NSIndexPath indexPathForRow:4 inSection:2];
    
   
   
    
    if (indexPath == row1) {
        
        NSPredicate *rent = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@",@"Аренда"];
        [self fetchEntitiesWithPredicates:rent];
        
    }else if (indexPath == row2) {
        
        NSPredicate *sell = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@",@"Продажа"];
        [self fetchEntitiesWithPredicates:sell];
        
    }else if (indexPath == row3) {
        
        NSPredicate *flat = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty contains [cd] %@",@"Квартира"];
        // NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[p1, p2]];
        
        [self fetchEntitiesWithPredicates:flat];
        
    }else if (indexPath == row4) {
        
        NSPredicate *house = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty  contains [cd] %@",@"Дом"];
        [self fetchEntitiesWithPredicates:house];
        
    }else if (indexPath == row5) {
        
        NSPredicate *nonLiving = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty  contains [cd] %@",@"Нежилое помещение"];
        [self fetchEntitiesWithPredicates:nonLiving];
        
        
    }else if (indexPath == row6) {
        NSPredicate *room = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty  contains [cd] %@",@"Комната"];
        [self fetchEntitiesWithPredicates:room];
        
    }else if (indexPath == row7) {
        
        NSPredicate *earth = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty  contains [cd] %@",@"Земельный участок"];
        [self fetchEntitiesWithPredicates:earth];
        
//    }else if () {
//
//        NSPredicate *rent = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty contains [cd] %@",@"Аренда"];
//        NSPredicate *house = [NSPredicate predicateWithFormat:@"SELF.typeOfProperty  contains [cd] %@",@"Дом"];
//        NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[rent, house]];
   // }
   
    
        
    
    }


}






#pragma mark - Configuring ticks

- (void)tableViewWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    if (indexPath.section == 1) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [cellSelectedArray removeObject:selectedCell.textLabel.text];
            
        }else{
            
            //  [cellSelectedArray addObject:selectedCell.textLabel.text];
            
            [cellSelectedArray addObject:selectedCell];
            NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
            
        }
        
        for (UITableViewCell *cell in [tableView visibleCells]) {
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section ) {
                cell.accessoryType = UITableViewCellAccessoryNone;

            }
        }
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        selectedCell.tag = indexPath.section;
        
        
    }else if (indexPath.section == 2) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark ) {
            
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [cellSelectedArray removeObject:selectedCell.textLabel.text];
            
        }else{
            // [cellSelectedArray addObject:selectedCell.textLabel.text];
            [cellSelectedArray addObject:selectedCell];
        }
        
        
        // uncheck all visible cells.
        for (UITableViewCell *cell in [tableView visibleCells]) {
            
            if (cell.accessoryType != UITableViewCellAccessoryNone && cell.tag == indexPath.section) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        selectedCell.tag = indexPath.section;
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
        NSLog(@"%lu",(unsigned long)cellSelectedArray.count);
        
    }
}



#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toFilteredResultsVC"]) {
        
        FilteredResultsVC *frVC = (FilteredResultsVC*)segue.destinationViewController;
        frVC.searchResults = [[NSMutableArray alloc] init];
        frVC.searchResults = self.entities;
        self.detailItem = frVC.detailItem;
        
        //        NSSortDescriptor *price = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
        //        NSSortDescriptor *address = [NSSortDescriptor sortDescriptorWithKey:@"address" ascending:YES selector:@selector(localizedStandardCompare:)];
        //        NSSortDescriptor *actionByProperty = [NSSortDescriptor sortDescriptorWithKey:@"actionByProperty" ascending:YES selector:@selector(localizedStandardCompare:)];
        
        
        //        NSPredicate *rent = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@",@"Аренда"];
        //        NSPredicate *sell = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@",@"Продажа"];
        
        
        
        //        NSIndexPath *indPa = [NSIndexPath indexPathForRow:0 inSection:1];
        //        NSIndexPath *indPathFor1Row = [NSIndexPath indexPathForRow:1 inSection:1];
        //
        //        UITableViewCell *selectedCell = [self.tableView indexPathForSelectedRow];
        //        NSIndexPath *ipForCell = [self.tableView indexPathForCell:selectedCell];
        //
        //NSPredicate *rent = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@",@"Аренда"];
        
        //[self fetchEntitiesWithPredicates:rent];
        
        
    }
}









#pragma marl - Helper


-(void)fetchEntitiesWithPredicates:(NSPredicate*)predicates {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    [fetchRequest setPredicate:predicates];
    
    self.filteredResults = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    // self.entities = [self.filteredResults  sortedArrayUsingDescriptors: sortDescriptors];
    self.entities = [self.filteredResults filteredArrayUsingPredicate:predicates];
    
    for (id object in self.filteredResults) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }
}

@end
