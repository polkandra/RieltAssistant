//
//  EstateObject.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 01.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EstateObject : NSObject

@property(strong,nonatomic) NSString* discription;
@property(assign,nonatomic) NSString* price;

-(id)initWithDiscription:(NSString*)discription price:(NSString*)price;

@end
