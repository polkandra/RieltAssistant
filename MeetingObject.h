//
//  MeetingObject.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 27.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetingObject : NSObject

@property(strong, nonatomic) NSString* phoneNumber;
@property(strong,nonatomic) NSString* objectName;
@property(strong,nonatomic) NSString* personName;
@property(strong, nonatomic) NSString* time;
@property(strong, nonatomic) NSString* date;
@property(strong, nonatomic) NSString* dateAndTime;
@property(strong, nonatomic) NSData *picture;


@end
