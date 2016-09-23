//
//  SSCalendarCountCache.m
//  eSchoolView
//
//  Created by Steven Preston on 8/22/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarCountCache.h"
#import "SSCalendarUtils.h"

@interface SSCalendarCountCache()

- (NSMutableDictionary *)monthDictionaryForYear:(NSInteger)year Month:(NSInteger)month createIfNil:(BOOL)createIfNil;

@end

@implementation SSCalendarCountCache

- (void)putDates:(NSArray *)dates
{
    for (NSDate *date in dates)
    {
        NSDateComponents *componenets = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        
        NSMutableDictionary *monthCache = [self monthDictionaryForYear:componenets.year Month:componenets.month createIfNil:YES];
        
        NSNumber *dayKey = [NSNumber numberWithInteger:componenets.day];
        NSNumber *dayCache = [monthCache objectForKey:dayKey];
        
        if (dayCache == nil)
        {
            dayCache = [NSNumber numberWithLong:componenets.day];
            [monthCache setObject:dayCache forKey:dayKey];
        }
    }
}


- (BOOL)hasEventsWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    NSMutableDictionary *monthCache = [self monthDictionaryForYear:year Month:month createIfNil:NO];
    
    if (monthCache != nil)
    {
        NSNumber *hasEvents = [monthCache objectForKey:[NSNumber numberWithInteger:day]];
        return hasEvents != nil;
    }
    
    return NO;
}


//Getter Methods

- (NSMutableDictionary *)monthDictionaryForYear:(NSInteger)year Month:(NSInteger)month createIfNil:(BOOL)createIfNil
{
    //Year Cache
    NSNumber *yearKey = [NSNumber numberWithInteger:year];
    NSMutableDictionary *yearCache = [self objectForKey:yearKey];
    
    if (yearCache == nil && createIfNil)
    {
        yearCache = [[NSMutableDictionary alloc] init];
        [self setObject:yearCache forKey:yearKey];
    }
    
    //Month Dictionary
    NSNumber *monthKey = [NSNumber numberWithInteger:month];
    NSMutableDictionary *monthCache = [yearCache objectForKey:monthKey];
    
    if (monthCache == nil && createIfNil)
    {
        monthCache = [NSMutableDictionary dictionary];
        [yearCache setObject:monthCache forKey:monthKey];
    }
    
    return monthCache;
}

@end
