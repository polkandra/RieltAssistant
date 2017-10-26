//
//  SelectMeetingCell.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectMeetingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *meetingPicture;
@property (weak, nonatomic) IBOutlet UILabel *addressOfMeeting;
@property (weak, nonatomic) IBOutlet UILabel *priceOfMetting;
@property (weak, nonatomic) IBOutlet UILabel *nameOfMeeting;



@end
