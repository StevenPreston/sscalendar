//
//  SSCalendarMonthView.m
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarMonthViewController.h"
#import "SSCalendarMonthHeaderView.h"
#import "SSCalendarDayCell.h"
#import "SSCalendarMonthlyLayout.h"
#import "SSCalendarUtils.h"
#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSDayNode.h"

@implementation SSCalendarMonthViewController


- (id)initWithView:(UICollectionView *)view
{
    self = [super init];
    if (self)
    {
        self.view = view;
        _view.collectionViewLayout = [[SSCalendarMonthlyLayout alloc] init];

        [view registerNib:[UINib nibWithNibName:@"SSCalendarDayCell" bundle:nil] forCellWithReuseIdentifier:@"DayCell"];
        [view registerNib:[UINib nibWithNibName:@"SSCalendarMonthHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthHeaderView"];
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
    SSCalendarMonthHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MonthHeaderView" forIndexPath:indexPath];
   
    
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
