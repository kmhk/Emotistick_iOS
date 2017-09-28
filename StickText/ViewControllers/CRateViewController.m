//
//  CRateViewController.m
//  StickText
//
//  Created by Mountain on 7/16/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "CRateViewController.h"
#import "iRate.h"

@interface CRateViewController ()

@end

@implementation CRateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // [iRate sharedInstance].applicationBundleID = @"com.tanya.emotistick";
        [iRate sharedInstance].appStoreID = 720694618;
        
        [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
        
        //enable preview mode
//        [iRate sharedInstance].previewMode = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRateNow:(id)sender {
    [[iRate sharedInstance] rateNowClicked];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onRemindMe:(id)sender {
    [[iRate sharedInstance] remindClicked];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onNoThanks:(id)sender {
    [[iRate sharedInstance] cancelClicked];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NoThanks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
