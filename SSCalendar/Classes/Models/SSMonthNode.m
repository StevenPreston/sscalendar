//
//  SSMonthNode.m
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSMonthNode.h"
#import "SSDayNode.h"
#import "SSCalendarUtils.h"

@implementation SSMonthNode

- (id)initWithYear:(NSInteger)year Month:(NSInteger)month WeekdayOfFirstDay:(NSInteger)aWeekdayOfFirstDay
{
    self = [super init];
    if (self)
    {
        value = month;
        weekdayOfFirstDay = aWeekdayOfFirstDay;
        dayCount = [SSCalendarUtils numberOfDaysInMonth:month Year:year];
        
        NSMutableArray *newDayNodes = [NSMutableArray arrayWithCapacity:dayCount];
        
        for (int i = 0; i < dayCount; i++)
        {
            SSDayNode *dayNode = [[SSDayNode alloc] initWithValue:i+1 Month:month Year:year Weekday:(weekdayOfFirstDay + i % 7) % 7];
            [newDayNodes addObject:dayNode];
        }
        
        dayNodes = [newDayNodes copy];
    }
    return self;
}


#pragma mark - Getter Methods

- (NSInteger)value
{
    return value;
}

- (NSArray *)dayNodes
{
    return dayNodes;
}

- (NSInteger)dayCount
{
    return dayCount;
}

- (NSInteger)weekdayOfFirstDay
{
    return weekdayOfFirstDay;
}

@end
