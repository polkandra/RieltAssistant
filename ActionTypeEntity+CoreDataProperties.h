//
//  ActionTypeEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "ActionTypeEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ActionTypeEntity (CoreDataProperties)

+ (NSFetchRequest<ActionTypeEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *rent;
@property (nullable, nonatomic, copy) NSString *sell;
@property (nullable, nonatomic, retain) EstateObjectEntity *estateObject;

@end

NS_ASSUME_NONNULL_END
