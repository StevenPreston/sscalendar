//
//  SSMonthNode.h
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSMonthNode : NSObject
{
    NSInteger value;
    NSArray *dayNodes;
    NSInteger dayCount;
    NSInteger weekdayOfFirstDay;
}

@property (nonatomic, readonly) NSInteger value;
@property (nonatomic, readonly) NSArray *dayNodes;
@property (nonatomic, readonly) NSInteger dayCount;
@property (nonatomic, readonly) NSInteger weekdayOfFirstDay;

- (id)initWithYear:(NSInteger)year Month:(NSInteger)month WeekdayOfFirstDay:(NSInteger)weekdayOfFirstDay;

@end
