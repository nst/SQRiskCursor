//
//  SQRiskCursor.h
//  RiskCursor
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SQRiskCursor : UIControl {
	CAGradientLayer *handleGradient;
	CAGradientLayer *sliderGradient;
	CAShapeLayer *shadowArcLayer;
	
	NSUInteger value;
	NSUInteger maxValue;
}

@property (nonatomic) NSUInteger maxValue; // default is 9
@property (nonatomic) NSUInteger value;

@end
