//
//  SSDataStore.h
//  eSchoolView
//
//  Created by Steven Preston on 7/2/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSCache, SSCalendarCountCache;

@interface SSDataController : NSObject
{
    BOOL requestingInfo;
}

@property (nonatomic, strong) SSCache *calendars;
@property (nonatomic, strong) SSCache *calendarCounts;

/** Data structure used to build and display the calendar. */
@property (nonatomic, copy) NSArray *calendarYears;

+ (SSDataController *)shared;

- (BOOL)isRequestingInfo;
- (BOOL)isInfoRequestRequired;

- (BOOL)areEventsLoadedForYear:(NSInteger)year Month:(NSInteger)month;
- (BOOL)hasEventsYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)day;
- (BOOL)isRequestingEventsForYear:(NSInteger)year Month:(NSInteger)month;

- (NSArray *)cachedEventsForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
- (SSCalendarCountCache *)cachedCalendarCount;

/** Updates the hasEvents flag on each day within the calendar years. */
- (void) updateCalendarYears;

@end
