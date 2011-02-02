//
//  UIColor+SQ.h
//  Swissquote
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import <UIKit/UIKit.h>


@interface UIColor (Swissquote)

+ (UIColor *)colorWithWebColor:(NSInteger)rgbValue;
+ (UIColor *)colorWithWebColorString:(NSString *)hexColor;

@end
