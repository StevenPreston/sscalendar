//
//  UIColor+StellarAdditions.m
//  ColorPicker
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2011 Stellar16. All rights reserved.
//

#import "UIColor+StellarAdditions.h"

@implementation UIColor (StellarAdditions)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{	
	//Convert the string into an int.
	unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
	NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    //Handle short color form.
	if(hexStringCleared.length == 3)
    {
		hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
							[hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
							[hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
	}
    
	if(hexStringCleared.length == 6)
    {
		hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
	}
	
	NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
	NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
	NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
	NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
	
	[[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
	[[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
	[[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
	[[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
	
	return [UIColor colorWithRed:((colorValueR)&0xFF)/255.0
						   green:((colorValueG)&0xFF)/255.0
							blue:((colorValueB)&0xFF)/255.0
						   alpha:((colorValueA)&0xFF)/255.0];
}

@end