//
//  SSStyles.h
//  Pods
//
//  Created by Steven Preston on 9/22/16.
//
//

#import <Foundation/Foundation.h>

@interface SSStyles : NSObject

+ (UIView *)separatorView;
+ (void)applyNavigationBarStyles;
+ (void)applyToolbarStyles;
+ (void)applyTableViewStyles;

+ (void)hideShadowOnNavigationBar:(UINavigationBar *)navigationBar;
+ (void)showShadowOnNavigationBar:(UINavigationBar *)navigationBar;

+ (UIFont *)lightFontOfSize:(CGFloat)size;
+ (UIFont *)fontOfSize:(CGFloat)size;
+ (UIFont *)boldFontOfSize:(CGFloat)size;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image HighlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

@end
