//
//  SSCalendarWeekHeaderView.m
//  Pods
//
//  Created by Steven Preston on 7/24/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarWeekHeaderView.h"
#import "SSConstants.h"

@implementation SSCalendarWeekHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:COLOR_BACKGROUND_OFF_WHITE];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *weekdays = [dateFormatter veryShortWeekdaySymbols];

    for (int i = 0; i < [weekdays count]; i++)
    {
        NSString *day = [weekdays objectAtIndex:i];

        CGRect frame = self.frame;
        frame.size.width = (int) frame.size.width / [weekdays count];
        frame.origin.x = i * frame.size.width;

        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.0f];
        label.text = day;

        [self addSubview:label];
    }
}

@end
