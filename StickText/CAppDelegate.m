////
////  CAppDelegate.m
////  StickText
////
////  Created by Mountain on 7/15/13.
////  Copyright (c) 2013 Cheng Long. All rights reserved.
////
//
//#import "DBManager.h"
//
//#import "CAppDelegate.h"
//
//#import "CRateViewController.h"
//#import "CStickTextViewController.h"
//#import <RevMobAds/RevMobAds.h>
//#import "Flurry.h"
//#import "RageIAPHelper.h"
//#import <Tapjoy/Tapjoy.h>
//
//#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-8002835753870526/8675109497"
//
//@implementation CAppDelegate
//
//@synthesize dbName;
//@synthesize dbPath;
//
//- (void)dealloc
//{
//    
//    splashInterstitial_.delegate = nil;//for admob
//    [splashInterstitial_ release];
//    
//    [dbPath release];
//    [dbName release];
//    if (dbManger != nil) {
//        [dbManger release];
//    }
//    
//    [_window release];
//    [_viewController release];
//    [super dealloc];
//}
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    [self initDatabase];
////    [NSThread sleepForTimeInterval:1.0];
//    
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
//    self.viewController = [[[CStickTextViewController alloc] initWithNibName:@"CStickTextViewController" bundle:nil] autorelease];
//    UINavigationController * nav = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
//    [nav.navigationBar setBarStyle:UIBarStyleBlack];
//    
//    [nav setNavigationBarHidden:YES];
//    
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
//    
//    
//    
//    [self showRateScreen];
//    [RevMobAds startSessionWithAppID:@"525392f74b96f52cd4000050"];
//    
//    //[Flurry startSession:@"5RCYNQ22JNYB46GMYX82"];
//    //push notification
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//    
//    [Tapjoy requestTapjoyConnect:@"64e2982f-21de-4482-b102-a05685ba1c40"//@"234d7513-e004-45c4-96c9-1761c000e264"//@"64e2982f-21de-4482-b102-a05685ba1c40"
//					   secretKey:@"wyGdQubKF3V753nICoOb"
//						 options:@{ TJC_OPTION_ENABLE_LOGGING : @(YES) }
//     // If you are not using Tapjoy Managed currency, you would set your own user ID here.
//     //TJC_OPTON_USER_ID : @"A_UNIQUE_USER_ID"
//     ];
//    
//    //admob
////    if ([dbManger.m_purchased count] == 0) {
////      
////    splashInterstitial_ = [[GADInterstitial alloc] init];
////    
////    splashInterstitial_.adUnitID = self.interstitialAdUnitID;
////    splashInterstitial_.delegate = self;
////    
////        UIImage* loadImage = [[UIImage alloc] init];
////        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
////        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
////            if (screenSize.height > 480.0f) {
////            loadImage = [UIImage imageNamed:@"Default-568h@2x__.png"];
////            } else {
////                loadImage = [UIImage imageNamed:@"Default.png"];
////            }
////        } else {
////            /*Do iPad stuff here.*/
////            loadImage = [UIImage imageNamed:@"Default.png"];
////        }
////        /*
////    [splashInterstitial_ loadAndDisplayRequest:[self createRequest]
////                                   usingWindow:self.window
////                                  initialImage:loadImage];*/
//////        [splashInterstitial_ loadRequest: [self createRequest]];
////    }
//    
//    int count = 0;
//    for (int i = 1; i<=3; i++) {
//        count += [dbManger getPurchased: i].count ;
//        
//    }
//    if (count == 0) {
//        [[RevMobAds session] showFullscreen];
//        
//    };
//    return YES;
//}
//
//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//}
//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
///*    int count = 0;
//    for (int i = 1; i<=3; i++) {
//        count += [dbManger getPurchased: i].count ;
//        
//    }
//    if (count == 0) {
//        [[RevMobAds session] showFullscreen];
//        
//    };*/
//        
//    
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//}
//
/////********************************************************************************
//#pragma mark - set database 
//- (void) initDatabase {
//    //database initialize
//    self.dbName = @"database.sqlite3";
//    
//    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
//    NSString* databaseDir = [self createDirectory:@"Database" atFilePath:documentsDir];
//	self.dbPath = [databaseDir stringByAppendingPathComponent:self.dbName];
//    NSLog(@"dbpath = %@", self.dbPath);
//	
//	[self checkAndCreateDB];
//        
//    // Create New Manager
//    dbManger = [[DBManager alloc] init];
//    
//    // Set Database Name of DBManager
//    [dbManger setM_dbName: self.dbPath];
//}
//
//- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
//{
//    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
//    if (&NSURLIsExcludedFromBackupKey == nil) { // iOS <= 5.0.1
//        const char* filePath = [[URL path] fileSystemRepresentation];
//
//        const char* attrName = "com.apple.MobileBackup";
//        u_int8_t attrValue = 1;
//
//        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//        return result == 0;
//    } else { // iOS >= 5.1
//        NSError *error = nil;
//        [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
//        return error == nil;
//    }
//}
//
//-(NSString* )createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath
//{
//    NSString *filePathAndDirectory = [filePath stringByAppendingPathComponent:directoryName];
//    NSError *error;
//    
//    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
//                                   withIntermediateDirectories:NO
//                                                    attributes:nil
//                                                         error:&error])
//    {
//        NSLog(@"Create directory error: %@", error);
//    }
//    return filePathAndDirectory;
//}
/////*********************************************************************************
//- (NSString *) getDBPath {
//	return self.dbPath;
//}
//
//- (void) checkAndCreateDB {
//	NSFileManager *fileMgr = [NSFileManager defaultManager];
//	if ([fileMgr fileExistsAtPath:self.dbPath]) {
//		NSLog(@"imageorganizer DB exist:%@", self.dbPath);
//		return;
//	}
//	
//	NSLog(@"no DB. create it");
//	NSString *dbPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.dbName];
//	[fileMgr copyItemAtPath: dbPathFromApp toPath:self.dbPath error: nil];
//}
//
//#pragma mark - show rate screen
//- (void) showRateScreen {
//    
//    BOOL noThanks = [[NSUserDefaults standardUserDefaults] boolForKey:@"NoThanks"];
//    if (noThanks) {
//        return;
//    }
//    
//    int nLaunchCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"luanch_count"] integerValue];
//    if (nLaunchCount && (nLaunchCount % 4) == 0) {
//        CRateViewController * viewController = [[[CRateViewController alloc] initWithNibName:getNibName(@"CRateViewController") bundle:nil] autorelease];
////        [self.window.rootViewController presentViewController:viewController animated:YES completion:nil];
//    [self.window.rootViewController pushViewController: viewController animated:YES];
//    }
//    nLaunchCount++;
//    [[NSUserDefaults standardUserDefaults] setInteger:nLaunchCount forKey:@"luanch_count"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
//{
//	NSLog(@"My token is: %@", deviceToken);
//}
//
//- (NSString *)interstitialAdUnitID {
//    return INTERSTITIAL_AD_UNIT_ID;
//}
//
//- (GADRequest *)createRequest {
//    GADRequest *request = [GADRequest request];
//    
//    // Make the request for a test ad. Put in an identifier for the simulator as
//    // well as any devices you want to receive test ads.
//    request.testDevices =
//    [NSArray arrayWithObjects:
//     // TODO: Add your device/simulator test identifiers here. They are
//     // printed to the console when the app is launched.
//     nil];
//    return request;
//}
//
//@end



//
//  CAppDelegate.m
//  StickText
//
//  Created by Mountain on 7/15/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "DBManager.h"

#import "CAppDelegate.h"

#import "CRateViewController.h"
#import "CStickTextViewController.h"
#import <RevMobAds/RevMobAds.h>
#import "Flurry.h"
#import "RageIAPHelper.h"
#import <Tapjoy/Tapjoy.h>
#include <sys/xattr.h>

#define INTERSTITIAL_AD_UNIT_ID @"ca-app-pub-8002835753870526/8675109497"

@implementation CAppDelegate

@synthesize dbName;
@synthesize dbPath;

- (void)dealloc
{
    
    splashInterstitial_.delegate = nil;//for admob
    [splashInterstitial_ release];
    
    [dbPath release];
    [dbName release];
    if (dbManger != nil) {
        [dbManger release];
    }
    
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initDatabase];
    //    [NSThread sleepForTimeInterval:1.0];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[CStickTextViewController alloc] initWithNibName:@"CStickTextViewController" bundle:nil] autorelease];
    UINavigationController * nav = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    [nav.navigationBar setBarStyle:UIBarStyleBlack];
    
    [nav setNavigationBarHidden:YES];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    
    [self showRateScreen];
    [RevMobAds startSessionWithAppID:@"525392f74b96f52cd4000050"];
    
    //[Flurry startSession:@"5RCYNQ22JNYB46GMYX82"];
    //push notification
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [Tapjoy requestTapjoyConnect:@"64e2982f-21de-4482-b102-a05685ba1c40"//@"234d7513-e004-45c4-96c9-1761c000e264"//@"64e2982f-21de-4482-b102-a05685ba1c40"
					   secretKey:@"wyGdQubKF3V753nICoOb"
						 options:@{ TJC_OPTION_ENABLE_LOGGING : @(YES) }
     // If you are not using Tapjoy Managed currency, you would set your own user ID here.
     //TJC_OPTON_USER_ID : @"A_UNIQUE_USER_ID"
     ];
    
    //admob
    //    if ([dbManger.m_purchased count] == 0) {
    //
    //    splashInterstitial_ = [[GADInterstitial alloc] init];
    //
    //    splashInterstitial_.adUnitID = self.interstitialAdUnitID;
    //    splashInterstitial_.delegate = self;
    //
    //        UIImage* loadImage = [[UIImage alloc] init];
    //        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    //            if (screenSize.height > 480.0f) {
    //            loadImage = [UIImage imageNamed:@"Default-568h@2x__.png"];
    //            } else {
    //                loadImage = [UIImage imageNamed:@"Default.png"];
    //            }
    //        } else {
    //            /*Do iPad stuff here.*/
    //            loadImage = [UIImage imageNamed:@"Default.png"];
    //        }
    //        /*
    //    [splashInterstitial_ loadAndDisplayRequest:[self createRequest]
    //                                   usingWindow:self.window
    //                                  initialImage:loadImage];*/
    ////        [splashInterstitial_ loadRequest: [self createRequest]];
    //    }
    
    int count = 0;
    for (int i = 1; i<=3; i++) {
        count += [dbManger getPurchased: i].count ;
        
    }
    if (count == 0) {
        [[RevMobAds session] showFullscreen];
        
    };
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    /*    int count = 0;
     for (int i = 1; i<=3; i++) {
     count += [dbManger getPurchased: i].count ;
     
     }
     if (count == 0) {
     [[RevMobAds session] showFullscreen];
     
     };*/
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

///********************************************************************************
#pragma mark - set database
- (void) initDatabase {
    //database initialize
    self.dbName = @"database.sqlite3";
    
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString* databaseDir = [self createDirectory:@"Database" atFilePath:documentsDir];
    NSString* fullDbPath = [databaseDir stringByAppendingPathComponent:self.dbName];
	self.dbPath = [NSURL fileURLWithPath: fullDbPath];
    [self checkAndCreateDB];
    [self addSkipBackupAttributeToItemAtURL: self.dbPath];
    
    NSLog(@"dbpath = %@", self.dbPath);
	
	
    
    // Create New Manager
    dbManger = [[DBManager alloc] init];
    
    // Set Database Name of DBManager
    [dbManger setM_dbName: [self.dbPath path]];
}

-(NSString* )createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath
{
    NSString *filePathAndDirectory = [filePath stringByAppendingPathComponent:directoryName];
    NSError *error;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
    return filePathAndDirectory;
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    if (&NSURLIsExcludedFromBackupKey == nil) { // iOS <= 5.0.1
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    } else { // iOS >= 5.1
        NSError *error = nil;
        [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        return error == nil;
    }
}

- (void) checkAndCreateDB {
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	if ([fileMgr fileExistsAtPath:[self.dbPath path]]) {
		NSLog(@"imageorganizer DB exist:%@", self.dbPath);
		return;
	}
	
	NSLog(@"no DB. create it");
	NSString *dbPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.dbName];
    
//    NSData* dbData = [NSData dataWithContentsOfFile: dbPathFromApp];
    
//    [dbData writeToURL: self.dbPath atomically: NO];
    [fileMgr copyItemAtPath:dbPathFromApp toPath:[self.dbPath path] error:nil];
}

#pragma mark - show rate screen
- (void) showRateScreen {
    
    BOOL noThanks = [[NSUserDefaults standardUserDefaults] boolForKey:@"NoThanks"];
    if (noThanks) {
        return;
    }
    
    int nLaunchCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"luanch_count"] integerValue];
    if (nLaunchCount && (nLaunchCount % 4) == 0) {
        CRateViewController * viewController = [[[CRateViewController alloc] initWithNibName:getNibName(@"CRateViewController") bundle:nil] autorelease];
        //        [self.window.rootViewController presentViewController:viewController animated:YES completion:nil];
        [self.window.rootViewController pushViewController: viewController animated:YES];
    }
    nLaunchCount++;
    [[NSUserDefaults standardUserDefaults] setInteger:nLaunchCount forKey:@"luanch_count"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
}

- (NSString *)interstitialAdUnitID {
    return INTERSTITIAL_AD_UNIT_ID;
}

- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as
    // well as any devices you want to receive test ads.
    request.testDevices =
    [NSArray arrayWithObjects:
     // TODO: Add your device/simulator test identifiers here. They are
     // printed to the console when the app is launched.
     nil];
    return request;
}

@end
