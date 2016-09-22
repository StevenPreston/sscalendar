//
//  SSCalendarMonthCell.m
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarMonthCell.h"
#import "SSCalendarMonthViewController.h"
#import "SSMonthNode.h"
#import "SSDayNode.h"
#import "SSCalendarUtils.h"

@implementation SSCalendarMonthCell

- (void)setMonth:(SSMonthNode *)month
{
    _month = month;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    NSDateComponents *today = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
    
    NSString *title = [[[[[NSDateFormatter alloc] init] shortMonthSymbols] objectAtIndex:_month.value - 1] uppercaseString];
    [title drawAtPoint:CGPointMake(0, -2.0f) withAttributes:@{ NSFontAttributeName: [SSStyles lightFontOfSize:14.0f] }];
    
    CGFloat headerHeight = 17.0f;
    for (SSDayNode *day in _month.dayNodes)
    {
        CGFloat x = day.weekday % 7 * 13.0f;
        CGFloat y = headerHeight + (day.value + _month.weekdayOfFirstDay - 1) / 7 * 15.0f;
        rect = CGRectMake(x, y, 13.0f, 13.0f);
        
        if ([day isEqualToDateComponents:today])
        {
            CGContextAddEllipseInRect(context, rect);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        }
        else
        {
            if (day.hasEvents > 0)
            {
                CGContextAddEllipseInRect(context, rect);
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:COLOR_SECONDARY].CGColor);
                CGContextDrawPath(context, kCGPathStroke);
            }
            
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        }
        
        rect.origin.y++;
        UIFont *font = [SSStyles fontOfSize:8.0f];
        NSString *dayText = [NSString stringWithFormat:@"%li", (long)day.value];

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];

        [dayText drawInRect:rect withAttributes:@{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle }];
    }
    
    CGContextRestoreGState(context);
}

@end
