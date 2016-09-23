//
//  SSCalendarCountCache.h
//  eSchoolView
//
//  Created by Steven Preston on 8/22/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCache.h"

@interface SSCalendarCountCache : SSCache

- (void)putDates:(NSArray *)dates;
- (BOOL)hasEventsWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;

@end
