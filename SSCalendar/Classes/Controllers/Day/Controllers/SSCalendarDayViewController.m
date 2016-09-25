//
//  SSCalendarDayView.m
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarDayViewController.h"
#import "SSCalendarDayLayout.h"
#import "SSCalendarEventsCell.h"
#import "SSDayNode.h"
#import "SSConstants.h"

@implementation SSCalendarDayViewController

#pragma mark - Lifecycle Methods

- (id)initWithView:(UICollectionView *)view
{
    self = [super init];
    if (self)
    {
        self.view = view;
        
        view.collectionViewLayout = [[SSCalendarDayLayout alloc] init];
        view.pagingEnabled = YES;

        NSBundle *bundle = [SSCalendarUtils calendarBundle];
        [view registerNib:[UINib nibWithNibName:@"SSCalendarEventsCell" bundle:bundle] forCellWithReuseIdentifier:@"EventsCell"];
    }
    return self;
}


#pragma mark - Setter Methods

- (void)setDays:(NSArray *)days
{
    _days = [days copy];
    
    //Set the start date.
    SSDayNode *startDay = [days objectAtIndex:0];
    startDate = startDay.date;
}


- (void)scrollToDay:(SSDayNode *)day animated:(BOOL)animated
{
    NSInteger index;
    
    if ([day isBefore:_day])
    {
        index = 0;
    }
    else
    {
        index = _visibleDays.count - 1;
    }
    
    
    self.day = day;
    
    if (_visibleDays.count > 0)
    {
        [_visibleDays replaceObjectAtIndex:index withObject:day];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [_view reloadItemsAtIndexPaths:@[indexPath]];
        
        [_view scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    }
    else
    {
        [self reloadDay];
    }
}


- (void)reloadDay
{
    NSMutableArray *newVisibleDays = [NSMutableArray arrayWithObject:_day];
    
    NSInteger index = [SSCalendarUtils numberOfDaysFrom:startDate To:_day.date];
    
    if (_day != [_days objectAtIndex:0])
    {
        SSDayNode *previousDay = [_days objectAtIndex:index - 1];
        [newVisibleDays insertObject:previousDay atIndex:0];
    }
    
    if (_day != [_days lastObject])
    {
        SSDayNode *nextDay = [_days objectAtIndex:index + 1];
        [newVisibleDays addObject:nextDay];
    }
    
    self.visibleDays = newVisibleDays;
    [_view reloadData];
    

    index = [_visibleDays indexOfObject:_day];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_view scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _visibleDays.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventsCell";
    SSCalendarEventsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.day = [_visibleDays objectAtIndex:indexPath.row];
    
    return cell;
}

@end
