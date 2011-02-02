//
//  RiskCursorViewController.m
//  RiskCursor
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import "RiskCursorViewController.h"
#import "SQRiskCursor.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation RiskCursorViewController

@synthesize cursor1;
@synthesize cursor2;
@synthesize cursor3;

@synthesize label;

- (void)viewWillAppear:(BOOL)animated {
	cursor2.maxValue = 5;
	cursor3.maxValue = 30;

	cursor2.transform = CGAffineTransformMakeRotation(M_PI/3);	

	cursor3.transform = CGAffineTransformMakeRotation(M_PI/2);	
}

- (IBAction)increment:(id)sender {
	cursor1.value = cursor1.value + 1;
}

- (IBAction)decrement:(id)sender {
	cursor1.value = cursor1.value == 0 ? 0 : cursor1.value - 1;
}

- (IBAction)valueChanged:(id)sender {
	label.text = [NSString stringWithFormat:@"%d", cursor1.value];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[label release];
	[cursor1 release];
	[cursor2 release];
	[cursor3 release];
    [super dealloc];
}

@end
