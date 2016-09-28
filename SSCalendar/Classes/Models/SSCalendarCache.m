//
//  SSCalendarCache.m
//  eSchoolView
//
//  Created by Steven Preston on 8/11/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarCache.h"
#import "SSCache.h"
#import "SSEvent.h"
#import "SSCalendarUtils.h"

@interface SSCalendarCache()

- (SSCache *)yearCacheForYear:(NSInteger)year createIfNil:(BOOL)createIfNil;
- (NSMutableDictionary *)monthDictionaryForYear:(NSInteger)year Month:(NSInteger)month createIfNil:(BOOL)createIfNil;

@end

@implementation SSCalendarCache

- (void)putEvents:(NSArray *)events
{
    for (SSEvent *event in events)
    {
        NSCalendar *calendar = [SSCalendarUtils calendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:event.startDate];

        NSMutableDictionary *monthCache = [self monthDictionaryForYear:comps.year Month:comps.month createIfNil:YES];

        NSNumber *dayKey = [NSNumber numberWithInteger:comps.day];
        NSMutableArray *dayCache = [monthCache objectForKey:dayKey];

        if (dayCache == nil)
        {
            dayCache = [NSMutableArray array];
            [monthCache setObject:dayCache forKey:dayKey];
        }

        [dayCache addObject:event];
    }
}


- (void)putEvents:(NSArray *)events ForYear:(NSInteger)year Month:(NSInteger)month
{
    NSMutableDictionary *monthCache = [self monthDictionaryForYear:year Month:month createIfNil:YES];
    
    for (SSEvent *event in events)
    {
        NSNumber *dayKey = [NSNumber numberWithInteger:event.day];
        NSMutableArray *dayCache = [monthCache objectForKey:dayKey];
        
        if (dayCache == nil)
        {
            dayCache = [NSMutableArray array];
            [monthCache setObject:dayCache forKey:dayKey];
        }
        
        [dayCache addObject:event];
    }
}


- (NSArray *)getEventsForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    NSMutableDictionary *monthCache = [self monthDictionaryForYear:year Month:month createIfNil:NO];
    
    if (monthCache != nil)
    {
        return [monthCache objectForKey:[NSNumber numberWithInteger:day]];
    }
    
    return nil;
}


- (BOOL)areEventsLoadedForYear:(NSInteger)year Month:(NSInteger)month
{
    //Year Cache
    SSCache *yearCache = [self yearCacheForYear:year createIfNil:NO];
    
    if (yearCache != nil)
    {
        NSNumber *monthKey = [NSNumber numberWithInteger:month];
        return [yearCache isDataValidForKey:monthKey];
    }
    
    return NO;
}


//Getter Methods

- (SSCache *)yearCacheForYear:(NSInteger)year createIfNil:(BOOL)createIfNil
{
    //Year Cache
    NSNumber *yearKey = [NSNumber numberWithInteger:year];
    SSCache *yearCache = [self objectForKey:yearKey];
    
    if (yearCache == nil && createIfNil)
    {
        yearCache = [[SSCache alloc] init];
        [self setObject:yearCache forKey:yearKey];
    }
    
    return yearCache;
}


- (NSMutableDictionary *)monthDictionaryForYear:(NSInteger)year Month:(NSInteger)month createIfNil:(BOOL)createIfNil
{
    //Year Cache
    SSCache *yearCache = [self yearCacheForYear:year createIfNil:createIfNil];
    
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
