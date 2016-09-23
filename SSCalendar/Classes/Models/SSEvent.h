//
//  SSEvent.h
//  Pods
//
//  Created by Steven Preston on 8/10/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSEvent : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, assign) NSInteger day;

@end
