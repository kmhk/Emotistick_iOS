//
//  CShareViewController.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CShareViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}

@property (nonatomic, strong) NSString * index;
@property (nonatomic, strong) NSString * serial;
@property (nonatomic, strong) NSString * gif_title;

- (IBAction)onTextMessage:(id)sender;
- (IBAction)onEmail:(id)sender;
- (IBAction)onFacebook:(id)sender;
- (IBAction)onTwitter:(id)sender;
- (IBAction)onTellAFriend:(id)sender;
- (IBAction)copyToClipBoard:(id)sender;
- (IBAction)onBack:(id)sender;

@end
