//
//  CStickTextViewController.h
//  StickText
//
//  Created by Mountain on 7/15/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"
#import "LeadboltOverlay.h"

@interface CStickTextViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray             * _arySticks;
    GADInterstitial *interstitial_;
}

@property (retain, nonatomic) IBOutlet UITableView *tableViewSticks;

@property(nonatomic, retain) GADInterstitial *interstitial;//for admob
- (IBAction)showInterstitial:(id)sender;

@end
