//
//  NSString+SQ.m
//  Swissquote
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import "NSString+SQ.h"

@implementation NSString (SQ)

- (BOOL)isOnlyFromCharacterSet:(NSCharacterSet *)aCharacterSet {
	NSString *s = [[[self lowercaseString] copy] autorelease];
	
	unichar c;
	for(NSUInteger i = 0; i < [s length]; i++) {
		[s getCharacters:&c range:NSMakeRange(i, 1)];
		if([aCharacterSet characterIsMember:c] == NO) {
			return NO;
		}
	}
	
	return YES;
}

- (BOOL)isHexadecimal {
	NSCharacterSet *hexadecimalCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"];
	return [self isOnlyFromCharacterSet:hexadecimalCharacterSet];
}

@end
