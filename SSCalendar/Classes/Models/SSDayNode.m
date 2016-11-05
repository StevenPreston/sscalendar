//
//  SSDayNode.m
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSDayNode.h"
#import "SSCalendarUtils.h"
#import "SSDataController.h"

@implementation SSDayNode


- (id)initWithValue:(NSInteger)value Month:(NSInteger)month Year:(NSInteger)year Weekday:(NSInteger)weekday
{
    self = [super init];
    if (self)
    {
        self.value = value;
        self.month = month;
        self.year = year;
        self.weekday = weekday;
    }
    return self;
}


//Helper Methods

- (BOOL)isBefore:(SSDayNode *)day
{
    if (day.year != _year)
    {
        return _year < day.year;
    }
    
    if (day.month != _month)
    {
        return _month < day.month;
    }
    
    return _value < day.value;
}


- (BOOL)isEqualToDate:(NSDate *)date
{
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    return [self isEqualToDateComponents:components];
}


- (BOOL)isEqualToDateComponents:(NSDateComponents *)components
{
    return components.day == _value && components.month == _month && components.year == _year;
}


- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[SSDayNode class]])
    {
        SSDayNode *day = object;
        return day.year == _year && day.month == _month && day.value == _value;
    }
    return NO;
}


//Getter Methods

- (NSDate *)date
{
    return [SSCalendarUtils dateWithYear:_year Month:_month Day:_value];
}


/*- (NSArray *)events
{
    return nil;//[[SSDataController shared] cachedEventsForYear:_year Month:_month Day:_value];
}*/


/*- (BOOL)hasEvents
{
    return [[SSDataController shared] hasEventsYear:_year Month:_month Date:_value];
}*/

@end
