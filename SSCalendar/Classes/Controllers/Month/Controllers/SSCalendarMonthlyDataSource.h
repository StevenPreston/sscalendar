//
//  SSCalendarMonthlyDataSource.h
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSCalendarMonthlyDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *years;
@property (nonatomic, weak) UICollectionView *view;

- (id)initWithView:(UICollectionView *)view;
- (void)updateLayoutForBounds:(CGRect)bounds;

@end
