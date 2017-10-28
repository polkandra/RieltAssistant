//
//  EstateObjectEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 28.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "EstateObjectEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EstateObjectEntity (CoreDataProperties)

+ (NSFetchRequest<EstateObjectEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *actionByProperty;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, retain) NSObject *arrayOfUsersPics;
@property (nullable, nonatomic, copy) NSString *discription;
@property (nullable, nonatomic, retain) NSObject *globalPictureArray;
@property (nullable, nonatomic, copy) NSString *kitchenArea;
@property (nonatomic) double latitude;
@property (nullable, nonatomic, copy) NSString *livingArea;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, copy) NSString *owner;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSData *picture;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *roomQuantity;
@property (nullable, nonatomic, copy) NSString *typeOfProperty;
@property (nullable, nonatomic, copy) NSString *wholeArea;
@property (nullable, nonatomic, retain) NSSet<MeetingObjectEntity *> *meetings;

@end

@interface EstateObjectEntity (CoreDataGeneratedAccessors)

- (void)addMeetingsObject:(MeetingObjectEntity *)value;
- (void)removeMeetingsObject:(MeetingObjectEntity *)value;
- (void)addMeetings:(NSSet<MeetingObjectEntity *> *)values;
- (void)removeMeetings:(NSSet<MeetingObjectEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
