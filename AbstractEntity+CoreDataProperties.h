//
//  AbstractEntity+CoreDataProperties.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 30.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "AbstractEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AbstractEntity (CoreDataProperties)

+ (NSFetchRequest<AbstractEntity *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
