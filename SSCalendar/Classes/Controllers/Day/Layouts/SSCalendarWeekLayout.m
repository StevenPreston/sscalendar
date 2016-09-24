//
//  SSCalendarWeekLayout.m
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarWeekLayout.h"

@implementation SSCalendarWeekLayout

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


- (void)updateLayoutForBounds:(CGRect)bounds
{
    self.itemSize = CGSizeMake(bounds.size.width / 7, 43.0f);
}

@end
