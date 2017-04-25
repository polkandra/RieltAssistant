//
//  StaticCell.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 25.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *objectTypeLabelInCell;
@property (weak, nonatomic) IBOutlet UILabel *actionTypeLabelInCell;

@end
