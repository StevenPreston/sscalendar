//
//  SSCache.h
//  eSchoolView
//
//  Created by Steven Preston on 8/12/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSCache : NSCache

@property (nonatomic, strong) NSMutableDictionary *timestamps;

- (BOOL)isDataValidForKey:(id)key;

@end
