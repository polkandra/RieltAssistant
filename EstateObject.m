//
//  EstateObject.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 01.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "EstateObject.h"

@implementation EstateObject

-(id)initWithDiscription:(NSString*)discription price:(NSString*)price {
    
    self = [super init];
    
    if (self) {
        _discription = discription;
        _price = price;
        
    }
    return  self;
}



@end
