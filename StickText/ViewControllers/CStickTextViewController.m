//
//  CStickTextViewController.m
//  StickText
//
//  Created by Mountain on 7/15/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "CStickTextViewController.h"
#import "CPunchLineViewController.h"
#import "CNoPunchLineViewController.h"
#import "CMyRecentViewController.h"
#import "CFavoriteViewController.h"
#import "CMyPurchasesViewController.h"
#import "CMyPurchasesPackViewController.h"
#import "CGetMoreViewController.h"
#import "CMoreAppsViewController.h"
#import "CHelpViewController.h"
#import "DBManager.h"
#import "Chartboost.h"
#import <RevMobAds/RevMobAds.h>
#import "CAppDelegate.h"
#import "CRateViewController.h"
#import <Tapjoy/Tapjoy.h>

#import "CStickCatCell.h"

#define LEADBOLTID @"154710677"

@interface CStickTextViewController ()

@end

NSString * strStickTitle[] = {
    @"Get more",
    @"With punch line",
    @"Without punch line",
    @"Recents",
    @"Favorites",
    @"My purchases",
    @"More apps",
    @"Free app",
    @"Help"
};


NSString * strIconNames[] = {
    @"getmore.png",
    @"punch_line.png",
    @"no_punch_line.png",
    @"recent.png",
    @"favorite.png",
    @"purchase.png",
    @"moreapps.png",
    @"free apps.png",
    @"help.png",
};

@implementation CStickTextViewController
static LeadboltOverlay *ad; 
@synthesize interstitial = interstitial_;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arySticks = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:strStickTitle[i], @"title", strIconNames[i], @"image", nil];
            [_arySticks addObject:dic];
        }
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
    //[self showRateScreen];
    //CRateViewController * viewController = [[[CRateViewController alloc] initWithNibName:getNibName(@"CRateViewController") bundle:nil] autorelease];
    CRateViewController *viewController = [[CRateViewController alloc] initWithNibName:@"CRateViewController" bundle:nil];
    //[self presentViewController:viewController animated:YES completion:nil];
    [[self navigationController] pushViewController:viewController animated:YES];
    [viewController release];*/
    
    // Load Display Ad
    

    //[ad loadStartAd:@"YOUR_LB_REENGAGEMENT_SECTION_ID" withAudio:@"YOUR_LB_AUDIO_ID"];
    
    // Initialize AppFireworks Analytics
    //[AppTracker startSession:@”YOUR_APPFIREWORKS_API_KEY” view:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    interstitial_.delegate = nil;//admob
    [interstitial_ release];
    
    [_tableViewSticks release];
    [_arySticks removeAllObjects];
    [_arySticks release];
    [super dealloc];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arySticks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return [CStickCatCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [CStickCatCell reuseIdentifier];
    CStickCatCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[CStickCatCell alloc] init] autorelease];
    }
    
    NSDictionary * dicStick = [_arySticks objectAtIndex:indexPath.row];
    [cell configureWithObject:dicStick];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self gotoNextPage:indexPath.row];
}

#pragma mark - go to next page
- (void) gotoNextPage:(int)index {
    UIViewController * viewController = nil;
    NSString* nonID = @"234d7513-e004-45c4-96c9-1761c000e264";
    switch (index) {
        case 0:
            viewController = [[[CGetMoreViewController alloc] initWithNibName:@"CGetMoreViewController" bundle:nil] autorelease];
            break;
        case 1:
            viewController = [[[CPunchLineViewController alloc] initWithNibName:@"CPunchLineViewController" bundle:nil] autorelease];
            break;
        case 2:
            viewController = [[[CNoPunchLineViewController alloc] initWithNibName:@"CNoPunchLineViewController" bundle:nil] autorelease];
            break;
        case 3:
            viewController = [[[CMyRecentViewController alloc] initWithNibName:@"CMyRecentViewController" bundle:nil] autorelease];
            break;
        case 4:
            viewController = [[[CFavoriteViewController alloc] initWithNibName:@"CFavoriteViewController" bundle:nil] autorelease];
            break;
        case 5:
            //viewController = [[[CMyPurchasesViewController alloc] initWithNibName:@"CMyPurchasesViewController" bundle:nil] autorelease];
            viewController = [[[CMyPurchasesPackViewController alloc] initWithNibName:@"CMyPurchasesPackViewController" bundle:nil] autorelease];
            break;
        case 6:
            //[Tapjoy showOffersWithCurrencyID:nonID withCurrencySelector:NO];
            //[TapjoyConnect showOffers];
            ad = [LeadboltOverlay createAdWithSectionid:LEADBOLTID view:self.view];
            [ad loadAd];
            break;
        case 7:
            [[RevMobAds session] showFullscreen];
            
            break;
        case 8:
            viewController = [[[CHelpViewController alloc] initWithNibName:@"CHelpViewController" bundle:nil] autorelease];
            break;
            
        default:
            viewController = nil;
            break;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    // Alert the error.
    UIAlertView *alert = [[[UIAlertView alloc]
                           initWithTitle:@"GADRequestError"
                           message:[error localizedDescription]
                           delegate:nil cancelButtonTitle:@"Drat"
                           otherButtonTitles:nil] autorelease];
    [alert show];
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];
}

@end
