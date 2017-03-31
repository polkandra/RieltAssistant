//
//  MainScreenCellTableViewCell.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 31.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageOfCell;
@property (weak, nonatomic) IBOutlet UILabel *nameOfObjectCell;
@property (weak, nonatomic) IBOutlet UILabel *priceOfObjectCell;







@end
