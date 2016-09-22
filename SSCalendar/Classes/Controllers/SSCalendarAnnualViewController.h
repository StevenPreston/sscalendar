//
//  SSCalendarAnnualViewController.h
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSContentViewController.h"

@class SSCalendarYearViewController;

@interface SSCalendarAnnualViewController : SSContentViewController <UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *yearView;
@property (nonatomic, strong) SSCalendarYearViewController *yearViewController;

@end
