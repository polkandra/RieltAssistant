//
//  SecondViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingsCell.h"
#import "MeetingObject.h"
#import "StyleKitName.h"
#import "EmptyCell.h"

@interface MeetingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray* myMeetingsDetailsData;

@end

