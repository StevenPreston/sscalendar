//
//  SSCalendarAnnualViewController.m
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualViewController.h"
#import "SSCalendarMonthlyViewController.h"
#import "SSCalendarAnnualDataSource.h"
#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSConstants.h"
#import "SSDataController.h"
#import "SSCalendarCountCache.h"

@implementation SSCalendarAnnualViewController


- (id)initWithEvents:(NSArray *)events
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {
        self.events = events;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[SSCalendarAnnualDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;

    _dataSource.years = [SSDataController shared].calendarYears;
    [SSDataController shared].events = _events;

    [_yearView reloadData];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_dataSource updateLayoutForBounds:_yearView.bounds];
}


#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSYearNode *year = _dataSource.years[indexPath.section];

    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithNibName:@"SSCalendarMonthlyViewController" bundle:bundle];
    
    NSInteger section = indexPath.section * year.months.count + indexPath.row;
    NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    viewController.startingIndexPath = startingIndexPath;
    viewController.years = _dataSource.years;

    [self.navigationController pushViewController:viewController animated:YES];
}

@end
