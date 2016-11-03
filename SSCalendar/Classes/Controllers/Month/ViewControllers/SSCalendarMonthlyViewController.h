//
//  SSCalendarMonthlyViewController.h
//  Pods
//
//  Created by Steven Preston on 7/24/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSDataController;

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

- (id)initWithDataController:(SSDataController *)dataController;
- (id)initWithEvents:(NSArray *)events;
- (IBAction)todayPressed:(id)sender;

@end
