//
//  SQRiskCursor.m
//  RiskCursor
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import "SQRiskCursor.h"
#import "UIColor+SQ.h"

static NSUInteger DEFAULT_MAX_VALUE = 9;
static float SHADOW_LAYER_OPACITY = 0.3;

@interface SQRiskCursor ()
@property (nonatomic, retain) CAGradientLayer *handleGradient;
@property (nonatomic, retain) CAGradientLayer *sliderGradient;
@property (nonatomic, retain) CAShapeLayer *shadowArcLayer;
@end


@implementation SQRiskCursor

@synthesize value;
@synthesize maxValue;
@synthesize handleGradient;
@synthesize sliderGradient;
@synthesize shadowArcLayer;

+ (CALayer *)tickLayerWithFrame:(CGRect)aFrame {
	CALayer *l = [CALayer layer];
	l.frame = aFrame;
	l.borderWidth = 1.0;
	l.borderColor = [UIColor whiteColor].CGColor;
	return l;
}

- (CGFloat)xPositionForHandleValue:(CGFloat)aValue offset:(CGFloat)anOffset {	
	CGFloat v = aValue;
	
	v = MAX(v, (float)0.0);
	v = MIN(v, (float)maxValue);
	
	CGFloat slidingWidth = self.bounds.size.width - 2*anOffset;
	return slidingWidth * (1.0 * v / (maxValue)) + anOffset;
}

- (CAGradientLayer *)buildSliderGradientLayer {
	
	CGFloat sliderCurveY = self.bounds.size.height / 6.0;
	
	CAGradientLayer *gl = [CAGradientLayer layer];
	
	gl.frame = CGRectMake(0.0, sliderCurveY, self.bounds.size.width, self.bounds.size.height - 2*sliderCurveY);
	gl.startPoint = CGPointMake(0.0, gl.bounds.size.height / 2.0);
	gl.endPoint = CGPointMake(1.0, gl.bounds.size.height / 2.0);
	
	gl.colors = [NSArray arrayWithObjects:
	   (id)[[UIColor colorWithWebColor:0x45CF40] CGColor],
	   (id)[[UIColor colorWithWebColor:0xFF9230] CGColor],
	   (id)[[UIColor colorWithWebColor:0xE13D3D] CGColor], nil];
	   
	gl.locations = [NSArray arrayWithObjects:
	   [NSNumber numberWithFloat:0.0],
	   [NSNumber numberWithFloat:0.5],
	   [NSNumber numberWithFloat:1.0], nil];
	
	CGFloat cornerRadius = self.bounds.size.height / 3.0;
	
	gl.cornerRadius = cornerRadius;
	gl.borderWidth = 2.0;
	gl.borderColor = [UIColor colorWithWebColor:0x4D4D4D].CGColor;
	
	CALayer *glossLayer = [CALayer layer];
	glossLayer.frame = CGRectMake(gl.frame.origin.x, 0.0, gl.frame.size.width, gl.frame.size.height / 2.0);
	glossLayer.backgroundColor = [UIColor whiteColor].CGColor;
	glossLayer.opacity = SHADOW_LAYER_OPACITY;
	glossLayer.cornerRadius = gl.cornerRadius;
	[gl addSublayer:glossLayer];
	
	for(NSUInteger i = 0; i <= maxValue; i++) {
		CGFloat x = [self xPositionForHandleValue:(float)i offset:cornerRadius];
		CALayer *l = [[self class] tickLayerWithFrame:CGRectMake(x, 0.0, 1.0, gl.bounds.size.height)];
		[gl addSublayer:l];
	}
	
	return gl;
}

- (CAShapeLayer *)buildShadowArcLayerWithSlider:(CALayer *)slider {
	
	CAShapeLayer *sl = [CAShapeLayer layer];
	
	sl.frame = CGRectMake(slider.bounds.size.width - slider.cornerRadius, slider.frame.origin.y, slider.cornerRadius, slider.bounds.size.height);
	sl.opacity = SHADOW_LAYER_OPACITY;
	sl.lineWidth = 0.0;
	sl.fillColor = [UIColor blackColor].CGColor;

	UIBezierPath *path = [UIBezierPath bezierPath];

	[path addArcWithCenter:CGPointMake(0.0, slider.bounds.size.height/2.0)
					radius:slider.bounds.size.height/2.0
			    startAngle:M_PI_2 * -1.0
				  endAngle:M_PI_2
			     clockwise:YES];
	
	sl.path = path.CGPath;
	
	/**/
	
	CGFloat x = [self xPositionForHandleValue:value offset:slider.cornerRadius];

	CALayer *rectangleLayer = [CALayer layer];
	
	rectangleLayer.backgroundColor = [UIColor blackColor].CGColor;
	rectangleLayer.frame = CGRectMake(-1.0 * x,
							 0,
							 -1.0 * x,
							 slider.frame.size.height);
	
	[sl addSublayer:rectangleLayer];
	
	return sl;
}

- (CAGradientLayer *)buildHandleGradientLayer {
	
	CGFloat handleWidth = self.bounds.size.width / 25;
	
	CAGradientLayer *gl = [CAGradientLayer layer];
	gl.frame = CGRectMake(0.0, 0.0, handleWidth, self.bounds.size.height);
	
	gl.colors = [NSArray arrayWithObjects:(id)[[UIColor lightGrayColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
	gl.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0], nil];
	
	gl.cornerRadius = handleWidth / 3.0;
	gl.borderWidth = 1.0;
	gl.borderColor = [UIColor colorWithWebColor:0x4D4D4D].CGColor;
	
	/**/
	
	CALayer *tick = [CALayer layer];
	tick.frame = CGRectMake(handleWidth / 2.0 - 1, 1.0/6.0 * gl.bounds.size.height, 2, 4.0/6.0 * gl.bounds.size.height);
	tick.borderWidth = 1.0;
	tick.borderColor = [UIColor grayColor].CGColor;
	
	[gl addSublayer:tick];
	
	return gl;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	
	if(maxValue == 0) self.maxValue = DEFAULT_MAX_VALUE;
	
	self.backgroundColor = [UIColor clearColor];
	
	self.sliderGradient = [self buildSliderGradientLayer];
	self.shadowArcLayer = [self buildShadowArcLayerWithSlider:sliderGradient];
	self.handleGradient = [self buildHandleGradientLayer];
		
	self.value = 0;
}

- (void)layoutSubviews {
	[handleGradient removeFromSuperlayer];
	[shadowArcLayer removeFromSuperlayer];
	[sliderGradient removeFromSuperlayer];

	[self.layer insertSublayer:sliderGradient atIndex:0];
	[self.layer insertSublayer:shadowArcLayer atIndex:1];
	[self.layer insertSublayer:handleGradient atIndex:2];
}

//- (void)drawRect:(CGRect)rect {
//	
//}

- (void)moveShadowLimitToStartPositionX:(CGFloat)x {
	CALayer *rectangleLayer = [[shadowArcLayer sublayers] objectAtIndex:0];
	
	CGFloat width = sliderGradient.bounds.size.width - shadowArcLayer.bounds.size.width - x;
	CGFloat originX = -1.0 * width;
	
	[rectangleLayer setValue:[NSNumber numberWithFloat:originX] forKeyPath:@"frame.origin.x"];
	[rectangleLayer setValue:[NSNumber numberWithFloat:width] forKeyPath:@"frame.size.width"];
}

- (void)moveHandleToValue:(CGFloat)aValue animated:(BOOL)animated {
	
	CGFloat x = [self xPositionForHandleValue:aValue offset:sliderGradient.cornerRadius];
	
	if(animated == NO) {
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
	}
		
	handleGradient.position = CGPointMake(x, (sliderGradient.bounds.size.height + sliderGradient.cornerRadius) / 2.0);
	
	[self moveShadowLimitToStartPositionX:x];
	
	if(animated == NO) {
		[CATransaction commit];
	}
}

- (void)setValue:(NSUInteger)aValue {
	
	value = MIN(aValue, maxValue);
	
	[self moveHandleToValue:(float)value animated:YES];
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)dealloc {
	
	[handleGradient release];
	[sliderGradient release];
	[shadowArcLayer release];
	
    [super dealloc];
}

- (CGFloat)touchValueForPoint:(CGPoint)p {
	CGFloat sliderContentsWidth = sliderGradient.bounds.size.width - 2*sliderGradient.cornerRadius;
	
	CGFloat paddedX = p.x - sliderGradient.cornerRadius;
	
	CGFloat touchValue = paddedX / sliderContentsWidth * maxValue;
	
	return touchValue;
}

- (void)didTouchPoint:(CGPoint)p animated:(BOOL)animated {
	CGFloat touchValue = [self touchValueForPoint:p];
	
	[self moveHandleToValue:(float)touchValue animated:animated];	
}

- (void)adjustTouchValueFromPoint:(CGPoint)p {
	CGFloat touchValue = roundf([self touchValueForPoint:p]);
	
	self.value = (NSUInteger)touchValue;
}

- (void)setMaxValue:(NSUInteger)i {
	maxValue = i;
	
	self.sliderGradient = [self buildSliderGradientLayer];
}

#pragma mark UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	[self sendActionsForControlEvents:UIControlEventTouchDown];
	
	CGPoint p = [touch locationInView:self];
	[self didTouchPoint:p animated:YES];
	
	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint p = [touch locationInView:self];
	
	if (CGRectContainsPoint(self.frame, p)) {
		[self sendActionsForControlEvents:UIControlEventTouchDragInside];
	} else {
		[self sendActionsForControlEvents:UIControlEventTouchDragOutside];
	}
	
	[self didTouchPoint:p animated:NO];
	
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint p = [touch locationInView:self];
	
	if (CGRectContainsPoint(self.bounds, p))
		[self sendActionsForControlEvents:UIControlEventTouchUpInside];
	else 
		[self sendActionsForControlEvents:UIControlEventTouchUpOutside];
	
	[self adjustTouchValueFromPoint:p];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
	[self sendActionsForControlEvents:UIControlEventTouchCancel];
}

@end
