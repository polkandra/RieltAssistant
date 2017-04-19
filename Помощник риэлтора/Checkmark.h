//
//  Checkmark.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 19.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Checkmark : UIView


typedef NS_ENUM( NSUInteger, CheckMarkStyle )
{
    CheckMarkStyleOpenCircle,
    CheckMarkStyleGrayedOut
};



@property (readwrite) bool checked;
@property (readwrite) CheckMarkStyle checkMarkStyle;



@end
