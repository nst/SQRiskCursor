//
//  RiskCursorViewController.h
//  RiskCursor
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import <UIKit/UIKit.h>

@class SQRiskCursor;

@interface RiskCursorViewController : UIViewController {
	IBOutlet UILabel *label;
	IBOutlet SQRiskCursor *cursor1;
	IBOutlet SQRiskCursor *cursor2;
	IBOutlet SQRiskCursor *cursor3;
}

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) SQRiskCursor *cursor1;
@property (nonatomic, retain) SQRiskCursor *cursor2;
@property (nonatomic, retain) SQRiskCursor *cursor3;

- (IBAction)increment:(id)sender;
- (IBAction)decrement:(id)sender;

- (IBAction)valueChanged:(id)sender;

@end
