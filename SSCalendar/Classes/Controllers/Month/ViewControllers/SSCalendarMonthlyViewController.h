//
//  SSCalendarMonthlyViewController.h
//  Pods
//
//  Created by Steven Preston on 7/24/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

//#import "SSContentViewController.h"

@class SSCalendarMonthlyDataSource;

@interface SSCalendarMonthlyViewController : UIViewController <UICollectionViewDelegate>
{
    IBOutlet UIView *separatorView;
    IBOutlet NSLayoutConstraint *separatorViewHeightConstraint;
    IBOutlet UIBarButtonItem *todayBarButtonItem;
}

@property (nonatomic, copy) NSArray *years;
@property (nonatomic, strong) NSIndexPath *startingIndexPath;
@property (nonatomic, strong) IBOutlet UICollectionView *yearView;
@property (nonatomic, strong) SSCalendarMonthlyDataSource *dataSource;

- (IBAction)todayPressed:(id)sender;

@end
