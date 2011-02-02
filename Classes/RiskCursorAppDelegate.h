//
//  RiskCursorAppDelegate.h
//  RiskCursor
//
//  Created by Nicolas Seriot on 29.11.10.
//  Copyright 2010 Swissquote Bank. All rights reserved.
//
//  You may use this code for information purpose,
//  but not reuse it as such without Swissquote written authorization.
//

#import <UIKit/UIKit.h>

@class RiskCursorViewController;

@interface RiskCursorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RiskCursorViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RiskCursorViewController *viewController;

@end

