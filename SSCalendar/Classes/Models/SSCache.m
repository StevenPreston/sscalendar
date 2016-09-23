//
//  SSCache.m
//  eSchoolView
//
//  Created by Steven Preston on 8/12/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCache.h"
#import "SSCalendarUtils.h"

@implementation SSCache

- (id)init
{
    self = [super init];
    if (self)
    {
        self.timestamps = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setObject:(id)obj forKey:(id)key
{
    [super setObject:obj forKey:key];
    
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    [_timestamps setObject:[NSNumber numberWithDouble:timestamp] forKey:key];
}


- (id)objectForKey:(id)key
{
    if ([self isDataValidForKey:key])
    {
        return [super objectForKey:key];
    }
    else
    {
        return nil;
    }
}


- (BOOL)isDataValidForKey:(id)key
{
    NSNumber *timestampObject = [_timestamps objectForKey:key];
    if (timestampObject != nil)
    {
        NSTimeInterval timestamp = [timestampObject doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSDate *today = [NSDate date];
        
        if ([SSCalendarUtils isDate1:date theSameDayAs:today])
        {
            return true;
        }
    }
    
    return false;
}

@end
