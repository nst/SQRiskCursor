//
//  UIColor+SQ.m
//  Swissquote
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import "UIColor+SQ.h"
#import "NSString+SQ.h"

@implementation UIColor (Swissquote)

+ (UIColor *)colorWithWebColor:(NSInteger)rgbValue {
	return [UIColor colorWithRed:((double)((rgbValue & 0xFF0000) >> 16))/255.0
						   green:((double)((rgbValue & 0xFF00) >> 8))/255.0
							blue:((double)(rgbValue & 0xFF))/255.0
						   alpha:1.0];
}

+ (UIColor *)colorWithWebColorString:(NSString *)hexColor {
	NSString *s = [[hexColor copy] autorelease];
	
    if ([s hasPrefix:@"#"]) s = [hexColor substringFromIndex:1];
    if ([s hasPrefix:@"0x"]) s = [hexColor substringFromIndex:2];
	
	if ([s isHexadecimal] == NO) return nil;
    if ([s length] != 6) return nil;
	
	int i = 0;
	sscanf([s cStringUsingEncoding:NSUTF8StringEncoding], "%x", &i);
	
    return [UIColor colorWithWebColor:i];
}

@end
