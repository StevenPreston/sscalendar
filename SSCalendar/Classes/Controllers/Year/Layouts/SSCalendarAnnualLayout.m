//
//  SSCalendarAnnualLayout.m
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualLayout.h"

@implementation SSCalendarAnnualLayout

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headerReferenceSize = CGSizeMake(0, 51.0f);
    self.minimumInteritemSpacing = 9.0f;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 10.0f, 0, 10.0f);
    self.itemSize = CGSizeMake(94.0f, 108.0f);
}


- (id)init
{
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

@end
