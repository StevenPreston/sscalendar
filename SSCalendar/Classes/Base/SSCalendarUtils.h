//
//  SSCalendarUtils.h
//  Pods
//
//  Created by Steven Preston on 7/30/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSCalendarUtils : NSObject

+ (NSBundle *)calendarBundle;
+ (NSCalendar *)calendar;
+ (NSInteger)currentYear;
+ (NSInteger)numberOfMonthsInYear;
+ (NSInteger)numberDaysInYear:(NSInteger)year;
+ (NSInteger)numberOfDaysInMonth:(NSInteger)month Year:(NSInteger)year;
+ (NSInteger)numberOfDaysFrom:(NSDate *)startDate To:(NSDate *)endDate;
+ (NSInteger)weekdayOfDate:(NSDate *)date;
+ (NSDate *)dateByAddingDays:(NSInteger)days To:(NSDate *)date;
+ (NSDate *)dateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
+ (NSDateComponents *)dateComponentsWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
+ (BOOL)isDate1:(NSDate *)date1 theSameDayAs:(NSDate *)date2;

@end
