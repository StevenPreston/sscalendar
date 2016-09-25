//
//  SSCalendarDayCell.m
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarDayCell.h"
#import "SSDayNode.h"
#import "SSConstants.h"

/**
 * Private class for selected background view.
 */
@interface _SelectedBackgroundView : UIView

@end

@implementation _SelectedBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect circleRect = CGRectMake(0, 0, 31.0f, 31.0f);
    circleRect.origin.x = (rect.size.width - circleRect.size.width) / 2;
    circleRect.origin.y = (rect.size.height - circleRect.size.height) / 2;
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextAddEllipseInRect(context, circleRect);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
    [super drawRect:rect];
}

@end


@interface SSCalendarDayCell()

- (void)updateViews;

@end

@implementation SSCalendarDayCell

#pragma mark - Lifecycle Methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.state = SSCalendarDayCellStateNone;
    
    separatorView = [SSStyles separatorView];
    [self addSubview:separatorView];
}


#pragma mark - Setter Methods

- (void)setDay:(SSDayNode *)day
{
    _day = day;
    
    _label.text = _day != nil ? [NSString stringWithFormat:@"%li", (long)_day.value] : @"";
    separatorView.hidden = _day == nil || _style != SSCalendarDayCellStyleMonthly;
    
    if ([_day isEqualToDate:[NSDate date]])
    {
        self.state = SSCalendarDayCellStateToday;
    }
    else if (_day.hasEvents > 0)
    {
        self.state = SSCalendarDayCellStateEvent;
    }
    else
    {
        self.state = SSCalendarDayCellStateNone;
    }
}


- (void)setStyle:(SSCalendarDayCellStyle)style
{
    _style = style;
    separatorView.hidden = _day == nil || _style != SSCalendarDayCellStyleMonthly;

    if (style == SSCalendarDayCellStyleMonthly)
    {
        separatorView.hidden = NO;
        self.selectedBackgroundView = nil;
    }
    else
    {
        separatorView.hidden = YES;
        
        _SelectedBackgroundView *view = [[_SelectedBackgroundView alloc] init];
        self.selectedBackgroundView = view;
    }
}


- (void)setState:(SSCalendarDayCellState)state
{
    _state = state;
    [self updateViews];
    [self setNeedsDisplay];
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateViews];
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateViews];
}


#pragma mark - UI Helper Methods

- (void)updateViews
{
    if (_state == SSCalendarDayCellStateToday ||
        ((self.isSelected || self.isHighlighted) && self.selectedBackgroundView != nil))
    {
        _label.textColor = [UIColor whiteColor];
    }
    else
    {
        _label.textColor = [UIColor blackColor];
    }
}


#pragma mark - Layout Methods

- (void)drawRect:(CGRect)rect
{
    if (_state != SSCalendarDayCellStateNone)
    {
        CGRect circleRect = CGRectMake(0, 0, 31.0f, 31.0f);
        circleRect.origin.x = (rect.size.width - circleRect.size.width) / 2;
        circleRect.origin.y = (rect.size.height - circleRect.size.height) / 2;

        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextAddEllipseInRect(context, circleRect);
        
        if (_state == SSCalendarDayCellStateEvent)
        {
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
            CGContextDrawPath(context, kCGPathStroke);
        }
        else if (_state == SSCalendarDayCellStateToday)
        {
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
            CGContextFillPath(context);
        }
        
        CGContextRestoreGState(context);
    }
    
    [super drawRect:rect];
}

    
- (void)layoutSubviews
{
    [super layoutSubviews];
    separatorView.frame = CGRectMake(-1.0f, 0, self.frame.size.width + 2.0f, [SSDimensions onePixel]);
}

@end
