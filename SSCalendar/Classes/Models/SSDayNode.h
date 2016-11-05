//
//  SSDayNode.h
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSDayNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger weekday;
@property (nonatomic, copy) NSArray *events;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, assign) BOOL hasEvents;

- (id)initWithValue:(NSInteger)value Month:(NSInteger)month Year:(NSInteger)year Weekday:(NSInteger)weekday;
- (BOOL)isBefore:(SSDayNode *)day;
- (BOOL)isEqualToDate:(NSDate *)date;
- (BOOL)isEqualToDateComponents:(NSDateComponents *)components;

@end
