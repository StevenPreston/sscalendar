//
//  SSCalendarAnnualViewController.h
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

//#import "SSContentViewController.h"

@class SSCalendarAnnualDataSource;

@interface SSCalendarAnnualViewController : UIViewController <UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *yearView;
@property (nonatomic, strong) SSCalendarAnnualDataSource *dataSource;

- (id)initWithEvents:(NSArray *)events;

@end
