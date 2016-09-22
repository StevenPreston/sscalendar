//
//  SSYearNode.m
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSDayNode.h"
#import "SSCalendarUtils.h"

@implementation SSYearNode

- (id)initWithValue:(NSInteger)aValue
{
    self = [super init];
    
    if (self)
    {
        value = aValue;
        weekdayOfFirstDay = [SSCalendarUtils weekdayOfDate:[SSCalendarUtils dateWithYear:value Month:1 Day:1]] - 1;
        
        NSMutableArray *newMonths = [NSMutableArray arrayWithCapacity:12];
        NSMutableArray *newDays = [NSMutableArray arrayWithCapacity:365];
        
        for (int i = 0; i < 12; i++)
        {
            NSInteger weekdayOfFirstDayOfMonth = (weekdayOfFirstDay + dayCount) % 7;
            
            SSMonthNode *monthNode = [[SSMonthNode alloc] initWithYear:value Month:i+1 WeekdayOfFirstDay:weekdayOfFirstDayOfMonth];
            [newMonths addObject:monthNode];
            
            [newDays addObjectsFromArray:monthNode.dayNodes];
            dayCount += monthNode.dayCount;
        }
        
        months = [newMonths copy];
        days = [newDays copy];
    }
    return self;
}


#pragma mark - Getter Methods

- (NSInteger)value
{
    return value;
}

- (NSArray *)months
{
    return months;
}

- (NSArray *)days
{
    return days;
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
