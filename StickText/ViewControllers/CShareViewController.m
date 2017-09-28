//
//  CShareViewController.m
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <Social/Social.h>

#import "UIImage+animatedGIF.h"

#import "CShareViewController.h"

#import "DBManager.h"

@interface CShareViewController ()

@end

@implementation CShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - button methods
- (IBAction)onTextMessage:(id)sender {
    [self copyToClipBoard:nil];
    NSString * stringURL = @"sms:";
    NSURL * url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)onEmail:(id)sender {
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Emotistick" message:@"Can not send mail at the moment. Please confirm email login in setting." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    // Email Subject
    NSString *emailTitle = @"Emotistick";    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:self.index ofType:@"gif"]];
    
    [mc addAttachmentData:data mimeType:@"image/gif" fileName:self.gif_title];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
        {
            NSLog(@"Mail sent");
            [self saveRecent];
        }
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onFacebook:(id)sender {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Can not post card to facebook at the moment. Please confirm facebook login in setting." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:self.index withExtension:@"gif"];
    UIImage * shareImage = [UIImage animatedImageWithAnimatedGIFURL:url];
    
    SLComposeViewController * facebookComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookComposeSheet addImage:shareImage];
    
    NSString* iTunesLink = @"https://itunes.apple.com/us/app/emotistick/id720694618?ls=1&mt=8";
    NSString *emailBody = [NSString stringWithFormat:@"Check out this great app called Emotistick I found in the Apple App Store!    \nIt has awesome entertaining stick figure animations.\n you can share via text and email messages!    Check it out NOW in the app store %@", iTunesLink];
    
    [facebookComposeSheet setInitialText:emailBody];
    
    [facebookComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString * title = @"Facebook";
        NSString * msg = nil;
        if (result == SLComposeViewControllerResultCancelled) {
            msg = @"Post cancelled!";
        }
        else if (result == SLComposeViewControllerResultDone) {
            msg = @"Posted successfully!";
            [self saveRecent];
        }
        else {
            msg = @"";
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:facebookComposeSheet animated:YES completion:nil];
}

- (IBAction)onTwitter:(id)sender {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Tweet" message:@"Can not post card to twitter at the moment. Please confirm twitter login in setting." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:self.index withExtension:@"gif"];
    UIImage * shareImage = [UIImage animatedImageWithAnimatedGIFURL:url];

    SLComposeViewController * tweetComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetComposeSheet addImage:shareImage];
    
    [tweetComposeSheet setInitialText:@"Check out this great app called Emotistick I found in the Apple App Store! https://itunes.apple.com/us/app/emotistick/id720694618?ls=1&mt=8"];
    
    [tweetComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString * title = @"Tweet";
        NSString * msg;
        if (result == SLComposeViewControllerResultCancelled) {
            msg = @"Post cancelled!";
        }
        else if (result == SLComposeViewControllerResultDone) {
            msg = @"Posted successfully!";
            
            [self saveRecent];
        }
        else {
            msg = @"";
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:tweetComposeSheet animated:YES completion:nil];
}
- (IBAction)onTellAFriend:(id)sender {
    
    [self copyToClipBoard:nil];
    
    
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Emotistick" message:@"Can not send mail at the moment. Please confirm email login in setting." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    // Email Subject
    NSString *emailTitle = @"Emotistick App";
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:self.index ofType:@"gif"]];
    
    [mc addAttachmentData:data mimeType:@"image/gif" fileName:self.gif_title];
    
    
    
    //NSString* iTunesLink = @"https://itunes.apple.com/us/app/emotistick/id720694618?ls=1&mt=8";
    //NSString *emailBody = [NSString stringWithFormat:@"Check out this great app called Emotistick I found in the Apple App Store!    <br>It has awesome entertaining stick figure animations you can share via text and email messages! <br> Check it out NOW in the app store  (<a href = '%@'>Appstore Link</a>) <br>", iTunesLink];
    NSString* emailBody = @"Check out this great app called Emotistick I found in the Apple App Store!    <br>It has awesome entertaining stick figure animations you can share via text and email messages! <br> Check it out NOW in the app store!";
	[mc setMessageBody:emailBody isHTML:YES];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}
- (IBAction)copyToClipBoard:(id)sender {
    NSString *gifPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.gif", self.index]];
    
    NSData *gifData = [[NSData alloc] initWithContentsOfFile:gifPath];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setData:gifData forPasteboardType:@"com.compuserve.gif"];
        
    [gifData release];
    
    [self saveRecent];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) saveRecent {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate];
    NSString * recent = [NSString stringWithFormat:@"%.0f", timeInterval];
    [dbManger updateStickRecent:self.serial recent:recent];
}

@end
