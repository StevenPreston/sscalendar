//
//  SSStyles.m
//  Pods
//
//  Created by Steven Preston on 9/22/16.
//
//

#import "SSConstants.h"

@implementation SSStyles

+ (UIView *)separatorView
{
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectZero];
    separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    return separatorView;
}


+ (void)applyNavigationBarStyles
{
    [UINavigationBar appearance].barTintColor = [UIColor colorWithHexString:COLOR_BACKGROUND_OFF_WHITE];
    [UINavigationBar appearance].tintColor = [UIColor colorWithHexString:COLOR_SECONDARY];
    
    //UIBarButtonItems
    NSDictionary *attributes = @{ NSFontAttributeName:[SSStyles lightFontOfSize:17.0f],
                                  NSForegroundColorAttributeName : [UIColor colorWithHexString:COLOR_SECONDARY] };
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];

    //UINavigationBar title.
    NSDictionary *attributes1 = @{ NSFontAttributeName: [SSStyles boldFontOfSize:17.0f],
                                   NSForegroundColorAttributeName : [UIColor colorWithHexString:COLOR_TEXT_TITLE] };
    [UINavigationBar appearance].titleTextAttributes = attributes1;
}


+ (void)applyToolbarStyles
{
    [UIToolbar appearance].translucent = NO;
    [UIToolbar appearance].barTintColor = [UIColor colorWithHexString:COLOR_BACKGROUND_OFF_WHITE];
}


+ (void)applyTableViewStyles
{
    //UITableViewHeaderFooterView
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor colorWithHexString:COLOR_BACKGROUND_OFF_WHITE]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:
    [SSStyles boldFontOfSize:15.0f]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor colorWithHexString:@"777777"]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setShadowOffset:CGSizeZero];
}


+ (void)hideShadowOnNavigationBar:(UINavigationBar *)navigationBar
{
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [[UIImage alloc] init];
}


+ (void)showShadowOnNavigationBar:(UINavigationBar *)navigationBar
{
    [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = nil;
}


+ (UIFont *)lightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}


+ (UIFont *)fontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}


+ (UIFont *)boldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}


+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image HighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

@end
