//
//  EstateTypeEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "EstateTypeEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EstateTypeEntity (CoreDataProperties)

+ (NSFetchRequest<EstateTypeEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *earth;
@property (nullable, nonatomic, copy) NSString *flat;
@property (nullable, nonatomic, copy) NSString *house;
@property (nullable, nonatomic, copy) NSString *nonLiving;
@property (nullable, nonatomic, copy) NSString *room;
@property (nullable, nonatomic, retain) EstateObjectEntity *estateObjects;

@end

NS_ASSUME_NONNULL_END
