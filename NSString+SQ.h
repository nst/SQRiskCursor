//
//  NSString+SQ.h
//  Swissquote
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import <Foundation/Foundation.h>

@interface NSString (SQ)

- (BOOL)isHexadecimal;
- (BOOL)isOnlyFromCharacterSet:(NSCharacterSet *)aCharacterSet;

@end
