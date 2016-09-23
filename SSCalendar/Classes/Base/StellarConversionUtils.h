//
//  StellarConversionUtils.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

@interface StellarConversionUtils : NSObject

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)stringTimeFromIntSeconds:(int)seconds;
+ (NSString *)stringTimeFromIntSeconds:(int)seconds withFormat:(NSString *)format;
+ (NSDate *)dateWithSystemTimeZoneFromDate: (NSDate*) sourceDate withGMTOffsetHours: (int) sourceGMTOffsetHours;

@end
