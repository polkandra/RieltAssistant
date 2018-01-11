//
//  EstateObjectEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 11.01.2018.
//  Copyright © 2018 Chebahatt. All rights reserved.
//
//

#import "EstateObjectEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EstateObjectEntity (CoreDataProperties)

+ (NSFetchRequest<EstateObjectEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *actionByProperty;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, retain) NSObject *arrayOfUsersPics;
@property (nullable, nonatomic, copy) NSString *detailInformation;
@property (nullable, nonatomic, copy) NSString *discription;
@property (nullable, nonatomic, retain) NSObject *globalPictureArray;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isLiked;
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
@property (nullable, nonatomic, copy) NSString *city;
//@property (nullable, nonatomic, retain) ActionTypeEntity *actionType;
@property (nullable, nonatomic, retain) NSSet<MeetingObjectEntity *> *meetingObjects;
//@property (nullable, nonatomic, retain) EstateTypeEntity *objectType;

@end

@interface EstateObjectEntity (CoreDataGeneratedAccessors)

- (void)addMeetingObjectsObject:(MeetingObjectEntity *)value;
- (void)removeMeetingObjectsObject:(MeetingObjectEntity *)value;
- (void)addMeetingObjects:(NSSet<MeetingObjectEntity *> *)values;
- (void)removeMeetingObjects:(NSSet<MeetingObjectEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
