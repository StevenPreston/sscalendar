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

@interface SSCalendarAnnualViewController()

@property (nonatomic, strong) SSDataController *dataController;

@end

@implementation SSCalendarAnnualViewController

- (id)initWithEvents:(NSArray *)events
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {

        self.dataController = [[SSDataController alloc] init];
        [_dataController setEvents:events];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[SSCalendarAnnualDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;

    _dataSource.years = _dataController.calendarYears;

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

    SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithDataController:_dataController];
    
    NSInteger section = indexPath.section * year.months.count + indexPath.row;
    NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    viewController.startingIndexPath = startingIndexPath;

    [self.navigationController pushViewController:viewController animated:YES];
}

@end
