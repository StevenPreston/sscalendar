//
//  SSCalendarMonthCell.m
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualCell.h"
#import "SSMonthNode.h"
#import "SSDayNode.h"
#import "SSConstants.h"

@implementation SSCalendarAnnualCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
}


- (void)setMonth:(SSMonthNode *)month
{
    _month = month;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    NSDateComponents *today = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                            fromDate:[NSDate date]];
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);

    CGFloat headerHeight = 17.0f;
    CGFloat dayWidth = self.frame.size.width / 7;

    [self drawTitle];

    for (SSDayNode *day in _month.dayNodes) {
        CGFloat x = day.weekday % 7 * dayWidth + 1.0f;
        CGFloat y = headerHeight + (day.value + _month.weekdayOfFirstDay - 1) / 7 * (dayWidth + 2.0f);
        rect = CGRectMake(x, y, dayWidth - 2.0f, dayWidth - 2.0f);
        
        if ([day isEqualToDateComponents:today]) {
            [self drawTodayCircleWithContext:context inRect:rect];
        } else {
            [self drawDayCircle:day withContext:context inRect:rect];
        }
        
        rect.origin.y++;

        [self drawTextForDay:day withRadius:dayWidth inRect:rect];
    }
    
    CGContextRestoreGState(context);
}


- (void)drawTitle
{
    NSString *title = [[[[NSDateFormatter alloc] init] shortMonthSymbols][_month.value - 1] uppercaseString];
    [title drawAtPoint:CGPointMake(0, -2.0f) withAttributes:@{ NSFontAttributeName: [SSStyles lightFontOfSize:14.0f] }];
}


- (void)drawTodayCircleWithContext:(CGContextRef)context inRect:(CGRect)rect
{
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
    CGContextFillPath(context);

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
}


- (void)drawDayCircle:(SSDayNode *)day withContext:(CGContextRef)context inRect:(CGRect)rect
{
    if (day.hasEvents > 0) {
        CGContextAddEllipseInRect(context, rect);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
    }
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
}


- (void)drawTextForDay:(SSDayNode *)day withRadius:(CGFloat)radius inRect:(CGRect)rect
{
    UIFont *font = [SSStyles fontOfSize:[SSCalendarAnnualCell fontSizeForRadius:radius]];
    NSString *dayText = [NSString stringWithFormat:@"%li", (long)day.value];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];

    [dayText drawInRect:rect withAttributes:@{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle }];
}


+ (CGFloat)fontSizeForRadius:(CGFloat)radius
{
    if (radius >= 17.0f) {
        return 11.0f;
    } else if (radius >= 16.0f) {
        return 10.0f;
    } else {
        return 8.0f;
    }
}

@end
