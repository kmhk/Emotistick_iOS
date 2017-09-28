//
//  CGetMoreViewController.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "CGetPackViewController.h"


@interface CGetMoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CGetPackViewControllerDelegate>
{
    //NSArray * myProducts;
    NSNumberFormatter * myPriceFormatter;
    
    NSMutableArray* boolArray;
}

@property (retain, nonatomic) IBOutlet UITableView *tableViewPacks;
@property (retain, nonatomic) IBOutlet UIRefreshControl * refreshControl;
@property (retain, nonatomic) IBOutlet UIButton* unlockAllButton;
@property (nonatomic, assign) NSMutableArray *myProducts;

- (IBAction)onBack:(id)sender;

- (IBAction)onRemoveAds:(id)sender;
- (IBAction)onRestoreIAP:(id)sender;
@end
