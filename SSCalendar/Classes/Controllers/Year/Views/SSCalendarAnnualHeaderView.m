//
//  SSCalendarYearHeaderView.m
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualHeaderView.h"
#import "SSConstants.h"

@implementation SSCalendarAnnualHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    separatorViewHeightConstraint.constant = [SSDimensions onePixel];
}

@end
