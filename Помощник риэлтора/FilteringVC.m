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
  
    //  self.entities = [[NSMutableArray alloc] init];
 
    
   
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    for (UITableViewCell *allCells in [self.tableView visibleCells]) {
        if ((allCells.accessoryType = UITableViewCellAccessoryCheckmark)) {
            allCells.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    
    [self.cellSelectedArray removeAllObjects];
}




#pragma mark - Actions

- (IBAction)startSearch:(UIBarButtonItem *)sender{

}


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0: {
            self.segmentedControl.selectedSegmentIndex == 0;
            NSPredicate *rent0 = [NSPredicate predicateWithFormat:@"roomQuantity contains [cd] %@", @"1 комната"];
            [self fetchEntitiesWithPredicates:rent0];
            break;
        }
        case 1: {
            self.segmentedControl.selectedSegmentIndex == 1;
            NSPredicate *rent1 = [NSPredicate predicateWithFormat:@"roomQuantity contains [cd] %@", @"2 комнаты"];
            [self fetchEntitiesWithPredicates:rent1];
            break;
        }
            
        case 2: {
            self.segmentedControl.selectedSegmentIndex == 2;
            NSPredicate *rent2 = [NSPredicate predicateWithFormat:@"roomQuantity contains [cd] %@", @"3 комнаты"];
            [self fetchEntitiesWithPredicates:rent2];
            break;
        }
        case 3: {
            self.segmentedControl.selectedSegmentIndex == 3;
            NSPredicate *rent3 = [NSPredicate predicateWithFormat:@"roomQuantity contains [cd] %@", @"4 комнаты"];
            [self fetchEntitiesWithPredicates:rent3];
            break;
        }
            
        case 4: {
            self.segmentedControl.selectedSegmentIndex == 4;
            NSPredicate *rent4 = [NSPredicate predicateWithFormat:@"roomQuantity contains [cd] %@", @"5 комнат и более"];
            [self fetchEntitiesWithPredicates:rent4];
            break;
        }
        
        default:break;
            
    }
    
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

#pragma mark - Helpers


-(void)fetchEntitiesWithPredicates:(NSPredicate*)predicates {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    [fetchRequest setPredicate:predicates];
    
    self.filteredResults = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    // self.entities = [self.filteredResults  sortedArrayUsingDescriptors: sortDescriptors];
    self.entities = [[self.filteredResults filteredArrayUsingPredicate:predicates] mutableCopy];
    
    for (id object in self.filteredResults) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }
}




- (void)configureTicksWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    if (indexPath.section == 1) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return;
        }
        
        if ([cellSelectedArray containsObject:selectedCell.textLabel.text] ) {
            [cellSelectedArray removeObject:selectedCell.textLabel.text];
            
        }else{
            
            [cellSelectedArray addObject:selectedCell];
    
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



- (void)configureSearchParamsWithIndexPaths:(NSIndexPath *)indexPath {
 
    NSIndexPath *row1 = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *row2 = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *row3 = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *row4 = [NSIndexPath indexPathForRow:1 inSection:2];
    NSIndexPath *row5 = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *row6 = [NSIndexPath indexPathForRow:3 inSection:2];
    NSIndexPath *row7 = [NSIndexPath indexPathForRow:4 inSection:2];
    
    
    if (indexPath == row1) {
        NSPredicate *rent = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@",@"Аренда"];
        [self fetchEntitiesWithPredicates:rent];
        
    }else if (indexPath == row2) {
        NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@",@"Продажа"];
        [self fetchEntitiesWithPredicates:sell];
        
    }else if (indexPath == row3) {
        NSPredicate *flat = [NSPredicate predicateWithFormat:@"typeOfProperty contains [cd] %@",@"Квартира"];
        [self fetchEntitiesWithPredicates:flat];
        
    }else if (indexPath == row4) {
        NSPredicate *house = [NSPredicate predicateWithFormat:@"typeOfProperty contains [cd] %@",@"Дом"];
        [self fetchEntitiesWithPredicates:house];
        
    }else if (indexPath == row5) {
        NSPredicate *nonLiving = [NSPredicate predicateWithFormat:@"typeOfProperty contains [cd] %@",@"Нежилое помещение"];
        [self fetchEntitiesWithPredicates:nonLiving];
        
    }else if (indexPath == row6) {
        NSPredicate *room = [NSPredicate predicateWithFormat:@"typeOfProperty contains [cd] %@",@"Комната"];
        [self fetchEntitiesWithPredicates:room];
        
   }else if (indexPath == row7) {
        NSPredicate *earth = [NSPredicate predicateWithFormat:@"typeOfProperty contains [cd] %@",@"Земельный участок"];
        [self fetchEntitiesWithPredicates:earth];
        

   }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self configureTicksWithIndexPath:indexPath tableView:tableView];
    
    [self configureSearchParamsWithIndexPaths:indexPath];
   
   
}



#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toFilteredResultsVC"]) {
        
        FilteredResultsVC *frVC = (FilteredResultsVC*)segue.destinationViewController;
        frVC.detailItem = self.detailItem;
        frVC.searchResults = [[NSMutableArray alloc] init];
        frVC.searchResults = self.entities;
      
        if ([cellSelectedArray containsObject:self.rentCell] && [cellSelectedArray containsObject:self.flatCell]) {
            NSPredicate *rent = [NSPredicate predicateWithFormat:@"SELF.actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Аренда", @"Квартира"];
           
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:rent];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
       
        }else if ([cellSelectedArray containsObject:self.rentCell] && [cellSelectedArray containsObject:self.houseCell]) {
            NSPredicate *rent = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Аренда", @"Дом"];
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:rent];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
        
        }else if ([cellSelectedArray containsObject:self.rentCell] && [cellSelectedArray containsObject:self.nonLivingCell]) {
            NSPredicate *rent = [NSPredicate predicateWithFormat:@"actionByProperty  contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Аренда", @"Нежилое помещение"];
           
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:rent];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.rentCell] && [cellSelectedArray containsObject:self.roomCell]) {
            NSPredicate *rent = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Аренда", @"Комната"];
          
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:rent];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.rentCell] && [cellSelectedArray containsObject:self.earthCell]) {
            NSPredicate *rent = [NSPredicate predicateWithFormat:@"actionByProperty  contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Аренда", @"Земельный участок"];
           
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:rent];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.sellCell] && [cellSelectedArray containsObject:self.flatCell]) {
            NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Продажа", @"Квартира"];
           
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:sell];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.sellCell] && [cellSelectedArray containsObject:self.houseCell]) {
            NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Продажа", @"Дом"];
           
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:sell];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.sellCell] && [cellSelectedArray containsObject:self.nonLivingCell]) {
            NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Продажа", @"Нежилое помещение"];
          
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:sell];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.sellCell] && [cellSelectedArray containsObject:self.roomCell]) {
            NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Продажа", @"Комната"];
            
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:sell];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }else if ([cellSelectedArray containsObject:self.sellCell] && [cellSelectedArray containsObject:self.earthCell]) {
            NSPredicate *sell = [NSPredicate predicateWithFormat:@"actionByProperty contains [cd] %@ AND typeOfProperty contains [cd] %@",@"Продажа", @"Земельный участок"];
            
            [self.entities removeAllObjects];
            [self fetchEntitiesWithPredicates:sell];
            frVC.searchResults = [[NSMutableArray alloc] init];
            frVC.searchResults = self.entities;
            
        }
        
    }
}


@end
