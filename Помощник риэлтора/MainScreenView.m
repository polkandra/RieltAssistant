//
//  ScreenDraw.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 19.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MainScreenView.h"
#import "StyleKitName.h"


@implementation MainScreenView


-(void)drawRect:(CGRect)rect {
    
    [StyleKitName drawGradient3WithFrame: self.bounds resizing:  StyleKitNameResizingBehaviorAspectFill];

    
}

@end
