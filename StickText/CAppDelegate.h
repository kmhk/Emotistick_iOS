////
////  CAppDelegate.h
////  StickText
////
////  Created by Mountain on 7/15/13.
////  Copyright (c) 2013 Cheng Long. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import "GADInterstitial.h"
//
//
//@class CStickTextViewController;
//
//@interface CAppDelegate : UIResponder <UIApplicationDelegate, GADInterstitialDelegate>
//{
//    GADInterstitial *splashInterstitial_;
//}
//
//@property (strong, nonatomic) UIWindow *window;
//
//@property (strong, nonatomic) CStickTextViewController *viewController;
//
//@property (nonatomic, retain) NSString *dbName;
//@property (nonatomic, retain) NSString *dbPath;
//
//@property(nonatomic, readonly) NSString *interstitialAdUnitID;//admob
//- (GADRequest *)createRequest;
//
//// Functinos for Database handling
//- (void) checkAndCreateDB;
//- (NSString *) getDBPath;
//
//@end
//
//  CAppDelegate.h
//  StickText
//
//  Created by Mountain on 7/15/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"


@class CStickTextViewController;

@interface CAppDelegate : UIResponder <UIApplicationDelegate, GADInterstitialDelegate>
{
    GADInterstitial *splashInterstitial_;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CStickTextViewController *viewController;

@property (nonatomic, retain) NSString *dbName;
@property (nonatomic, retain) NSURL*dbPath;

@property(nonatomic, readonly) NSString *interstitialAdUnitID;//admob
- (GADRequest *)createRequest;

// Functinos for Database handling
- (void) checkAndCreateDB;

@end
