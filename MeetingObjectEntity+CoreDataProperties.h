//
//  MeetingObjectEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 06.12.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "MeetingObjectEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MeetingObjectEntity (CoreDataProperties)

+ (NSFetchRequest<MeetingObjectEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *dateAndTime;
@property (nullable, nonatomic, copy) NSString *meetDetails;
@property (nullable, nonatomic, copy) NSString *objectName;
@property (nullable, nonatomic, copy) NSString *personName;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, retain) NSData *picture;
@property (nullable, nonatomic, retain) EstateObjectEntity *estateObject;

@end

NS_ASSUME_NONNULL_END
