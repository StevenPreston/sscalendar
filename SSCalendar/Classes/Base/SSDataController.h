//
//  SSDataStore.h
//  eSchoolView
//
//  Created by Steven Preston on 7/2/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSCalendarCache, SSCalendarCountCache;

@interface SSDataController : NSObject

@property (nonatomic, strong) SSCalendarCache *calendarCache;
@property (nonatomic, strong) SSCalendarCountCache *calendarCountCache;

/** Data structure used to build and display the calendar. */
@property (nonatomic, copy) NSArray *calendarYears;

+ (SSDataController *)shared;

- (BOOL)areEventsLoadedForYear:(NSInteger)year Month:(NSInteger)month;
- (BOOL)hasEventsYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)day;
- (NSArray *)cachedEventsForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
- (SSCalendarCountCache *)cachedCalendarCount;

/** Updates the hasEvents flag on each day within the calendar years. */
- (void)updateCalendarYears;

@end
