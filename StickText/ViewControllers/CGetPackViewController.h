//
//  CGetPackViewController.h
//  StickText
//
//  Created by Wang on 13-10-25.
//  Copyright (c) 2013年 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKProduct;

@class CGetPackViewController;
@protocol CGetPackViewControllerDelegate <NSObject>
- (void)addItemViewController:(CGetPackViewController *)controller didFinishEnteringItem:(int)item;
@end


@interface CGetPackViewController : UIViewController
{
    NSNumberFormatter * myPriceFormatter;
}
@property (assign) int index;
@property (assign) SKProduct* product;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UIButton* unlockButton;
@property (retain, nonatomic) IBOutlet UIScrollView	*scrollView;
@property (retain, nonatomic) IBOutlet UIImageView *previewView;

@property (nonatomic, retain) id <CGetPackViewControllerDelegate> delegate;
@end
