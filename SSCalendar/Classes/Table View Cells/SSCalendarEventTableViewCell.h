//
//  SSCalendarEventTableCell.h
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSEvent;

@interface SSCalendarEventTableViewCell : UITableViewCell
{
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *locationLabel;
}

@property (nonatomic, strong) SSEvent *event;

+ (CGFloat)heightForEvent:(SSEvent *)event forWidth:(CGFloat)width;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
