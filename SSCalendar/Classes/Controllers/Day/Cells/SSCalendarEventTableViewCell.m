//
//  SSCalendarEventTableViewCell.m
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarEventTableViewCell.h"
#import "SSEvent.h"
#import "SSConstants.h"

@implementation SSCalendarEventTableViewCell

#define kWidthTime 66

//Static Methods

+ (CGFloat)heightForEvent:(SSEvent *)event forWidth:(CGFloat)width
{
    CGFloat w = width - 2 * PADDING;
    if (event.startTime.length > 0)
    {
        w = w - PADDING - kWidthTime;
    }
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    
    CGFloat height = PADDING;
    CGRect rect = [event.name boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell nameFont] }
                                           context:nil];
    height += rect.size.height;
    height += PADDING_SMALL;
    
    if (event.desc.length > 0)
    {
        rect = [event.desc boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell descriptionFont] }
                                               context:nil];
        height += rect.size.height;
        height += PADDING_SMALL;
    }
    
    if (event.location.length > 0)
    {
        rect = [event.location boundingRectWithSize:maxSize
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell locationFont] }
                                        context:nil];
        height += rect.size.height;
        height += PADDING_SMALL;
    }
    
    height += PADDING_SMALL;
    
    return height;
}

+ (UIFont *)nameFont
{
    return [SSStyles fontOfSize:15.0f];
}

+ (UIFont *)descriptionFont
{
    return [SSStyles lightFontOfSize:13.0f];
}

+ (UIFont *)locationFont
{
    return [SSStyles fontOfSize:12.0f];
}


//Lifecycle Methods

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.clipsToBounds = YES;
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        timeLabel.font = nameLabel.font = [SSCalendarEventTableViewCell nameFont];
        descriptionLabel.font = [SSCalendarEventTableViewCell descriptionFont];
        locationLabel.font = [SSCalendarEventTableViewCell locationFont];
        
        locationLabel.textColor = [UIColor colorWithHexString:COLOR_TEXT_LIGHT];
        
        nameLabel.numberOfLines = descriptionLabel.numberOfLines = 0;
        
        [self.contentView addSubview:timeLabel];
        [self.contentView addSubview:nameLabel];
        [self.contentView addSubview:descriptionLabel];
        [self.contentView addSubview:locationLabel];
        
        timeLabel.backgroundColor = nameLabel.backgroundColor = descriptionLabel.backgroundColor = locationLabel.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


//Setter Methods

- (void)setEvent:(SSEvent *)event
{
    _event = event;
    
    nameLabel.text = event.name;
    timeLabel.text = event.startTime;
    descriptionLabel.text = event.desc;
    locationLabel.text = event.location;
}


//Layout Methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGFloat timeWidth = timeLabel.frame.size.width;
    CGFloat x = PADDING;
    CGFloat y = PADDING;
    CGFloat width = self.frame.size.width - 2 * PADDING;
    
    if (_event.startTime.length > 0)
    {
        timeWidth = kWidthTime;
        width = width - PADDING - kWidthTime;
        x = x + timeWidth + PADDING;
    }
    else
    {
        timeWidth = 0;
    }
    

    CGFloat height = [_event.name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell nameFont] }
                                               context:nil].size.height;
    CGFloat timeHeight = [_event.startTime boundingRectWithSize:maxSize
                                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell nameFont] }
                                                        context:nil].size.height;
    
    timeLabel.frame = CGRectMake(PADDING, y, timeWidth, timeHeight);
    nameLabel.frame = CGRectMake(x, y, width, height);

    y = y + height + PADDING_SMALL;
    
    if (_event.desc.length > 0)
    {
        height = [_event.desc boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell descriptionFont] }
                                           context:nil].size.height;
        descriptionLabel.frame = CGRectMake(x, y, width, height);
    
        y = y + height + PADDING_SMALL;
    }
    
    if (_event.location.length > 0)
    {
        height = [_event.location boundingRectWithSize:maxSize
                                           options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes:@{ NSFontAttributeName: [SSCalendarEventTableViewCell locationFont] }
                                           context:nil].size.height;
    
        locationLabel.frame = CGRectMake(x, y, width, height);
    }
}

@end
