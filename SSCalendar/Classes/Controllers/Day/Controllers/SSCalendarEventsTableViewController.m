//
//  SSCalendarEventsTableViewController.m
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarEventsTableViewController.h"
#import "SSCalendarEventTableViewCell.h"
#import "SSConstants.h"

@implementation SSCalendarEventsTableViewController

#pragma mark - Lifecycle Methods

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self)
    {
        self.tableView = tableView;
    }
    return self;
}


#pragma mark - Setter Methods

- (void)setEvents:(NSArray *)events
{
    _events = [events copy];
    _tableView.scrollEnabled = _events.count > 0;
    [_tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _events.count == 0 ? 1 : _events.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_events.count > 0)
    {
        return [SSCalendarEventTableViewCell heightForEvent:[_events objectAtIndex:indexPath.row] forWidth:tableView.frame.size.width];
    }
    else
    {
        return LOADING_TABLE_VIEW_CELL_HEIGHT;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_events.count == 0)
    {
        static NSString *LoadingCellIdentifier = @"LoadingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier];
            cell.textLabel.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithHexString:COLOR_TEXT_DARK];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.textLabel.text = @"No Events";
        }
        return cell;
    }
    else
    {
        static NSString *EventCellIdentifier = @"EventCell";
        
        SSCalendarEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventCellIdentifier];
        if (cell == nil)
        {
            cell = [[SSCalendarEventTableViewCell alloc] initWithReuseIdentifier:EventCellIdentifier];
        }
        cell.event = [_events objectAtIndex:indexPath.row];
        return cell;
    }
}

@end
