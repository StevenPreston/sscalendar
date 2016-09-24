//
//  SSCalendarDayLayout.m
//  Pods
//
//  Created by Steven Preston on 7/31/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarDayLayout.h"

@implementation SSCalendarDayLayout

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        [self awakeFromNib];
    }
    return self;
}

@end
