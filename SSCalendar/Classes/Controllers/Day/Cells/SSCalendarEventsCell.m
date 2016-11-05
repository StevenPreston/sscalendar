//
//  SSCalendarEventsCell.m
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarEventsCell.h"
#import "SSCalendarEventsTableViewController.h"
#import "SSDayNode.h"
#import "SSDataController.h"
//#import "SSLoadingView.h"

@implementation SSCalendarEventsCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableViewController = [[SSCalendarEventsTableViewController alloc] initWithTableView:_tableView];
    _tableView.dataSource = _tableViewController;
    _tableView.delegate = _tableViewController;
    
    /*NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SSLoadingView" owner:self options:nil];
    loadingView = [topLevelObjects objectAtIndex:0];
    loadingView.frame = self.bounds;
    [loadingView showLoading:NO Message:nil Animated:NO];
    [self.contentView addSubview:loadingView];*/
}


#pragma mark - Setter Methods

- (void)setDay:(SSDayNode *)day
{
    _day = day;
    _tableViewController.events = day.events;
    
    /*if ([[SSDataController shared] isRequestingEventsForYear:_day.year Month:_day.month])
    {
        [loadingView showLoading:YES Message:NSLocalizedString(@"LoadingLabel", @"") Animated:NO];
    }
    else
    {
        [loadingView showLoading:NO Message:nil Animated:YES];
    }*/
}

@end
