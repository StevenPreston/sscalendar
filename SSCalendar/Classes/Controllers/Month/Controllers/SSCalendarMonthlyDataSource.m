//
//  SSCalendarMonthlyDataSource.h
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarMonthlyDataSource.h"
#import "SSCalendarMonthlyHeaderView.h"
#import "SSCalendarMonthlyLayout.h"
#import "SSCalendarDayCell.h"
#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSDayNode.h"
#import "SSConstants.h"

@implementation SSCalendarMonthlyDataSource


- (id)initWithView:(UICollectionView *)view
{
    self = [super init];
    if (self)
    {
        self.view = view;
        _view.collectionViewLayout = [[SSCalendarMonthlyLayout alloc] init];

        NSBundle *bundle = [SSCalendarUtils calendarBundle];
        [view registerNib:[UINib nibWithNibName:@"SSCalendarDayCell" bundle:bundle] forCellWithReuseIdentifier:@"DayCell"];
        [view registerNib:[UINib nibWithNibName:@"SSCalendarMonthlyHeaderView" bundle:bundle] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthlyHeaderView"];
    }
    return self;
}

- (void)updateLayoutForBounds:(CGRect)bounds
{
    [((SSCalendarMonthlyLayout *) _view.collectionViewLayout) updateLayoutForBounds:bounds];
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _years.count * 12;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger yearIndex = section / 12;
    NSInteger monthIndex = section % 12;
    
    SSYearNode *year = [_years objectAtIndex:yearIndex];
    SSMonthNode *month = [year.months objectAtIndex:monthIndex];
    
    return month.dayCount + month.weekdayOfFirstDay;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SSCalendarMonthlyHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthlyHeaderView" forIndexPath:indexPath];
   
    
    NSInteger yearIndex = indexPath.section / 12;
    NSInteger monthIndex = indexPath.section % 12;
    
    SSYearNode *year = [_years objectAtIndex:yearIndex];
    SSMonthNode *month = [year.months objectAtIndex:monthIndex];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    view.label.text = [[[formatter shortMonthSymbols] objectAtIndex:monthIndex] uppercaseString];
    view.label.textColor = [UIColor colorWithHexString:COLOR_SECONDARY];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
    CGFloat labelOffset = month.weekdayOfFirstDay * layout.itemSize.width + 6.0f;

    view.leadingConstraint.constant = labelOffset;

    return view;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DayCell";
    SSCalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.style = SSCalendarDayCellStyleMonthly;
    
  
    NSInteger yearIndex = indexPath.section / 12;
    NSInteger monthIndex = indexPath.section % 12;
    
    SSYearNode *year = [_years objectAtIndex:yearIndex];
    SSMonthNode *month = [year.months objectAtIndex:monthIndex];
    
    NSInteger dayIndex = indexPath.row - month.weekdayOfFirstDay;
    
    if (dayIndex >= 0)
    {
        SSDayNode *day = [month.dayNodes objectAtIndex:dayIndex];
        cell.day = day;
    }
    else
    {
        cell.day = nil;
    }

    return cell;
}

@end
