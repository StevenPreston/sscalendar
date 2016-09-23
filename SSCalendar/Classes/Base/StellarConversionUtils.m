//
//  StellarConversionUtils.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarConversionUtils.h"

#define FORMAT_DATE_DEFAULT	@"ccc, dd MMM yyyy HH:mm:ss Z"
#define FORMAT_TIME_DEFAULT	@"HH:mm:ss"
#define FORMAT_TIME_MIN_SEC	@"mm:ss"

#pragma mark Class extension (private methods)
@interface StellarConversionUtils ()

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;

@end

@implementation StellarConversionUtils


#pragma mark - Date Util Methods

//
// Returns a date from a string in a format specified by DEFAULT_DATE_FORMAT.
//
+ (NSDate *)dateFromString:(NSString *)string
{
	//Convert using default format.
	NSDate *result = [self dateFromString:string withFormat:FORMAT_DATE_DEFAULT];
	return result;
}


//
// Returns a date from a string in a format supplied uses DEFAULT_DATE_FORMAT if format is nil or empty.
//
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
	//Handle the empty date string.
	if ((string == nil) || ([string length] == 0))
    {
		return nil;
	}
	
	//Handle the empty formatter string.
	if ((format == nil) || ([format length] == 0))
    {
		format = FORMAT_DATE_DEFAULT;
	}
	
	//Setup the standard date formatter.
	NSDateFormatter *formatter = [StellarConversionUtils dateFormatterWithFormat:format];
	
	//Create the date.
	NSDate *result = [formatter dateFromString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	return result;
}


//
// returns a string from a date using the DEFAULT_DATE_FORMAT
//
+ (NSString *)stringFromDate:(NSDate *)date
{
	//Format using default format.
	NSString *result = [self stringFromDate:date withFormat:FORMAT_DATE_DEFAULT];	
	return result;
}


//
// returns a string from a date using the format supplied
//
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
	//Handle the empty formatter string.
	if ((format == nil) || ([format length] ==0))
    {
		format = FORMAT_DATE_DEFAULT;
	}
	
	// set up the standard date formatter
	NSDateFormatter *formatter = [StellarConversionUtils dateFormatterWithFormat:format];
	
	// create formatted date string
	NSString *result = [formatter stringFromDate:date];
	return result;
}


#pragma mark - Time Utility Methods

//
// Returns a string time from a duration in seconds using the default format.
//
+ (NSString *)stringTimeFromIntSeconds:(int)seconds
{
	//Format using default format.
	NSString *result = [self stringTimeFromIntSeconds:seconds withFormat:FORMAT_TIME_DEFAULT];
	return result;
}


//
// Returns a string time from a duration in seconds using the format supplied.
//
+ (NSString *)stringTimeFromIntSeconds:(int)seconds withFormat:(NSString *)format
{
	// handle the empty formatter string
	if ((format == nil) || ([format length] == 0))
    {
		format = FORMAT_TIME_DEFAULT;
	}
	
	//Setup date formatter to ignore the time zone.
	NSDateFormatter *formatter = [StellarConversionUtils dateFormatterWithFormat:format];
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	//Create a date object from the seconds.
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:(double)seconds];
	
	//Create formatted time string.
	NSString *result = [formatter stringFromDate:date];
	return result;
}


#pragma mark - Class extension (private methods)

//
// Utility method to return a standard date formatter to use internally.
//
+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
	//Set up the formatter.
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

	//Specify to use the Mac OS 10.4 format strings e.g. "HH:mm" instead of % formatting.
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:format];	
	return formatter;
}


+ (NSDate *)dateWithSystemTimeZoneFromDate:(NSDate *)sourceDate withGMTOffsetHours:(int)sourceGMTOffsetHours
{
	NSInteger sourceGMTOffset = sourceGMTOffsetHours * 60 * 60;
	NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];

	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];    
    NSInteger daylightSavingOffset = 0;
    
    if ([destinationTimeZone isDaylightSavingTime])
    {
        daylightSavingOffset = [destinationTimeZone daylightSavingTimeOffset];
    }
    
	NSTimeInterval interval = - daylightSavingOffset + destinationGMTOffset - sourceGMTOffset;

	NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
	return destinationDate;
}

@end
