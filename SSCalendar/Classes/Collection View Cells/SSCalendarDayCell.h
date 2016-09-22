//
//  SSCalendarDayCell.h
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

typedef NS_ENUM(NSInteger, SSCalendarDayCellStyle)
{
    SSCalendarDayCellStyleMonthly,
    SSCalendarDayCellStyleWeekly
};

typedef NS_ENUM(NSInteger, SSCalendarDayCellState)
{
    SSCalendarDayCellStateNone,
    SSCalendarDayCellStateToday,
    SSCalendarDayCellStateEvent
};

@class SSDayNode;

@interface SSCalendarDayCell : UICollectionViewCell
{
    UIView *separatorView;
}

@property (nonatomic, strong) SSDayNode *day;
@property (nonatomic, assign) SSCalendarDayCellStyle style;
@property (nonatomic, assign) SSCalendarDayCellState state;
@property (nonatomic, strong) IBOutlet UILabel *label;

@end
