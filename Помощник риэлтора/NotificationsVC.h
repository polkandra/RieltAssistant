//
//  NotificationsVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NotificationsVC : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSMutableArray *cellSelectedArray;
@property(assign, nonatomic) NSInteger selectedRow;

@end
