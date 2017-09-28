//
//  CHelpViewController.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHelpViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView	*scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *helpText;
- (IBAction)onBack:(id)sender;

@end
