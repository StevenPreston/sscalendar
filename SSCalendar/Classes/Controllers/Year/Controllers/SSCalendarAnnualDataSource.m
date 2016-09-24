//
//  SSCalendarAnnualDataSource.m
//  Pods
//
//  Created by Steven Preston on 7/29/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualDataSource.h"
#import "SSCalendarAnnualHeaderView.h"
#import "SSCalendarAnnualLayout.h"
#import "SSCalendarAnnualCell.h"
#import "SSCalendarUtils.h"
#import "SSYearNode.h"

@implementation SSCalendarAnnualDataSource

- (id)initWithView:(UICollectionView *)view
{
    self = [super init];
    if (self)
    {
        self.view = view;
        _view.collectionViewLayout = [[SSCalendarAnnualLayout alloc] init];
        
        [view registerNib:[UINib nibWithNibName:@"SSCalendarAnnualCell" bundle:nil] forCellWithReuseIdentifier:@"AnnualCell"];
        [view registerNib:[UINib nibWithNibName:@"SSCalendarAnnualHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AnnualHeaderView"];
    }
    return self;
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _years.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SSYearNode *year = [_years objectAtIndex:section];
    return year.months.count;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SSYearNode *year = [_years objectAtIndex:indexPath.section];
    
    SSCalendarAnnualHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AnnualHeaderView" forIndexPath:indexPath];
    view.label.text = [NSString stringWithFormat:@"%li", (long)year.value];
    return view;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSYearNode *year = [_years objectAtIndex:indexPath.section];
    
    static NSString *CellIdentifier = @"AnnualCell";
    SSCalendarAnnualCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.month = [year.months objectAtIndex:indexPath.row];
    return cell;
}

@end
