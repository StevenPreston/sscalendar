//
//  SSDataStore.m
//  eSchoolView
//
//  Created by Steven Preston on 7/2/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSDataController.h"
#import "SSCalendarUtils.h"
#import "SSYearNode.h"
#import "SSDayNode.h"

@interface SSDataController()

- (void)requestEventsWithYear:(NSInteger)year Month:(NSInteger)month DistrictId:(NSString *)districtId BuildingId:(NSString *)buildingId;
- (void)requestEventCountWithStartYear:(NSInteger)startYear StartMonth:(NSInteger)startMonth EndYear:(NSInteger)endYear EndMonth:(NSInteger)endMonth DistrictId:(NSString *)districtId BuildingId:(NSString *)buildingId;
- (void)requestNewsWithUrl:(NSString *)url DistrictId:(NSString *)districtId BuildingId:(NSString *)buildingId;
- (NSString *)keyForDistrictId:(NSString *)districtId BuildingId:(NSString *)buildingId;
- (void)storeItems:(NSArray *)items inCache:(NSCache *)cache withKey:(NSString *)key;

@end

@implementation SSDataController

#pragma mark - Static Methods

/**
 * Static method to implement this class as a singleton.
 */
+ (SSDataController *)shared
{
    static SSDataController *_sharedDataStore = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
    ^{
        _sharedDataStore = [[self alloc] init];
    });

    return _sharedDataStore;
}

#pragma mark - Lifecycle Methods

- (id)init
{
    self = [super init];
    if (self)
    {
        self.calendars = [[SSCache alloc] init];
        self.calendarCounts = [[SSCache alloc] init];
    }
    return self;
}

- (void)requestEventCountWithStartYear:(NSInteger)startYear StartMonth:(NSInteger)startMonth EndYear:(NSInteger)endYear EndMonth:(NSInteger)endMonth
{
    //[self requestEventCountWithStartYear:startYear StartMonth:startMonth EndYear:endYear EndMonth:endMonth DistrictId:_district.id BuildingId:_building.id];
}

- (BOOL)requestEventsWithYear:(NSInteger)year Month:(NSInteger)month
{
    //Only request events if they aren't already loaded and a request isn't in process
    if (![self areEventsLoadedForYear:year Month:month] && ![self isRequestingEventsForYear:year Month:month])
    {
        //[self requestEventsWithYear:year Month:month DistrictId:_district.id BuildingId:_building.id];
        return YES;
    }
    
    return NO;
}

#pragma mark - Event Request Methods

- (BOOL)areEventsLoadedForYear:(NSInteger)year Month:(NSInteger)month
{
    //NSString *key = [self keyForDistrictId:_district.id BuildingId:_building.id];
    SSCalendarCache *calendar = [_calendars objectForKey:@""];
    
    return [calendar areEventsLoadedForYear:year Month:month];
}


- (BOOL)hasEventsYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)day
{
    //NSString *key = [self keyForDistrictId:_district.id BuildingId:_building.id];
    SSCalendarCountCache *calendarCount = [_calendarCounts objectForKey:@""];
    
    return [calendarCount hasEventsWithYear:year Month:month Day:day];
}


- (BOOL)isRequestingEventsForYear:(NSInteger)year Month:(NSInteger)month
{
    /*for (SSGetEventsRequest *request in eventsRequests)
    {
        if (request.year == year && request.month == month)
        {
            return true;
        }
    }*/
    
    return false;
}

- (NSArray *)cachedEventsForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    //NSString *key = [self keyForDistrictId:_district.id BuildingId:_building.id];
    SSCalendarCache *calendar = [_calendars objectForKey:@""];
    
    if (calendar != nil)
    {
        return [calendar getEventsForYear:year Month:month Day:day];
    }
    
    return nil;
}


- (SSCalendarCountCache *)cachedCalendarCount
{
    //NSString *key = [self keyForDistrictId:_district.id BuildingId:_building.id];
    return [_calendarCounts objectForKey:@""];
}


- (void)storeItems:(NSArray *)items inCache:(NSCache *)cache withKey:(NSString *)key
{
    if (items.count > 0)
    {
        [cache setObject:items forKey:key];
    }
}


- (NSArray *)calendarYears
{
    if (_calendarYears == nil)
    {
        NSInteger year = [SSCalendarUtils currentYear];
        
        SSYearNode *yearNode = [[SSYearNode alloc] initWithValue:year];
        SSYearNode *yearNode1 = [[SSYearNode alloc] initWithValue:year + 1];
        
        self.calendarYears = @[yearNode, yearNode1];
    }
    
    return _calendarYears;
}


- (void)updateCalendarYears
{
    for (SSYearNode *year in _calendarYears)
    {
        for (SSDayNode *day in year.days)
        {
            day.hasEvents = [[SSDataController shared] hasEventsYear:day.year Month:day.month Date:day.value];
        }
    }
}

@end
