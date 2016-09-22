//
//  SSYearNode.h
//  Pods
//
//  Created by Steven Preston on 8/9/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSDayNode;

@interface SSYearNode : NSObject
{
    NSInteger value;
    NSArray *months;
    NSArray *days;
    NSInteger dayCount;
    NSInteger weekdayOfFirstDay;
}

@property (nonatomic, readonly) NSInteger value;
@property (nonatomic, readonly) NSArray *months;
@property (nonatomic, readonly) NSArray *days;
@property (nonatomic, readonly) NSInteger dayCount;
@property (nonatomic, readonly) NSInteger weekdayOfFirstDay;

- (id)initWithValue:(NSInteger)value;

@end
