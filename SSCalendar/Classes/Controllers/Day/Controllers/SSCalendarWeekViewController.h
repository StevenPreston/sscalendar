//
//  SSCalendarWeekView.h
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSDayNode;

@interface SSCalendarWeekViewController : NSObject <UICollectionViewDataSource>
{
    NSArray *days;
    NSDate *startDate;
}

@property (nonatomic, copy) NSArray *years;
@property (nonatomic, readonly) NSArray *days;
@property (nonatomic, readonly) NSDate *startDate;
@property (nonatomic, weak) UICollectionView *view;

- (id)initWithView:(UICollectionView *)view;
- (void)updateLayoutForBounds:(CGRect)bounds;

@end
