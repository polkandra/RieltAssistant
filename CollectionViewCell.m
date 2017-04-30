//
//  CollectionViewCell.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell


-(void)awakeFromNib {
    [super awakeFromNib];
    
    
}



-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
   
    {
        self.layer.opacity = 1.0;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
    }else{
        
        self.layer.opacity = 1.0;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = [UIColor redColor];    }
}

@end
