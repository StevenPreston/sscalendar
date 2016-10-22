//
//  SSCalendarMonthlyViewController.m
//  Pods
//
//  Created by Steven Preston on 7/24/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarMonthlyViewController.h"
#import "SSCalendarMonthlyDataSource.h"
#import "SSCalendarDailyViewController.h"
#import "SSCalendarDayCell.h"
#import "SSYearNode.h"
#import "SSDayNode.h"
#import "SSConstants.h"
#import "SSDataController.h"
#import "SSCalendarCountCache.h"

@interface SSCalendarMonthlyViewController()

- (void)scrollToIndexPath:(NSIndexPath *)indexPath updateTitle:(BOOL)updateTitle;

@end

@implementation SSCalendarMonthlyViewController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    todayBarButtonItem.title = @"Today";
    
    separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    separatorViewHeightConstraint.constant = [SSDimensions onePixel];

    self.dataSource = [[SSCalendarMonthlyDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;
    
    _dataSource.years = _years;

    [self refresh];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SSStyles hideShadowOnNavigationBar:self.navigationController.navigationBar];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SSStyles showShadowOnNavigationBar:self.navigationController.navigationBar];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_dataSource updateLayoutForBounds:_yearView.bounds];
    
    if (_startingIndexPath != nil)
    {
        [self scrollToIndexPath:_startingIndexPath updateTitle:NO];
        self.startingIndexPath = nil;
    }
}


- (void)refresh
{
    SSCalendarCountCache *calendarCounts = [SSDataController shared].calendarCountCache;
    if (calendarCounts == nil)
    {
        SSYearNode *firstYear = [_dataSource.years objectAtIndex:0];
        SSYearNode *lastYear = [_dataSource.years lastObject];
    }
    else
    {
        [[SSDataController shared] updateCalendarYears];
        [_yearView reloadData];
    }
}


#pragma mark - UI Action Methods

- (IBAction)todayPressed:(id)sender
{
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    
    NSInteger monthCount = 0;
    for (SSYearNode *year in _years)
    {
        if (year.value == components.year)
        {
            monthCount = monthCount + components.month - 1;
            break;
        }
        else
        {
            monthCount = monthCount + year.months.count;
        }
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:monthCount];
    [self scrollToIndexPath:indexPath updateTitle:YES];
}


#pragma mark - UI Helper Methods

- (void)scrollToIndexPath:(NSIndexPath *)indexPath updateTitle:(BOOL)updateTitle
{
    [_yearView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _yearView.collectionViewLayout;
    
    CGPoint offset = _yearView.contentOffset;
    offset.y = offset.y - layout.headerReferenceSize.height;
    _yearView.contentOffset = offset;
    
    if (updateTitle)
    {
        NSInteger year = ((SSYearNode *) [_years objectAtIndex:indexPath.section / 12]).value;
        self.title = [NSString stringWithFormat:@"%li", (long)year];
    }
}


#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    SSCalendarDayCell *cell = (SSCalendarDayCell *) [collectionView cellForItemAtIndexPath:indexPath];

    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    SSCalendarDailyViewController *viewController = [[SSCalendarDailyViewController alloc] initWithNibName:@"SSCalendarDailyViewController" bundle:bundle];
    viewController.years = _years;
    viewController.day = cell.day;
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = [_yearView visibleCells];
    
    for (SSCalendarDayCell *cell in visibleCells)
    {
        if (cell.day != nil && cell.frame.origin.y >= 0)
        {
            self.title = [NSString stringWithFormat:@"%li", (long)cell.day.year];
            break;
        }
    }
}

@end
