//
//  CGetPackViewController.m
//  StickText
//
//  Created by Wang on 13-10-25.
//  Copyright (c) 2013年 Cheng Long. All rights reserved.
//

#import "CGetPackViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface CGetPackViewController ()

@end

@implementation CGetPackViewController
@synthesize delegate;
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
    
    myPriceFormatter = [[NSNumberFormatter alloc] init];
    [myPriceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [myPriceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
   [myPriceFormatter setLocale:_product.priceLocale];
    NSString* price = [myPriceFormatter stringFromNumber:_product.price];
    
//    NSString *titleLabelText = [NSString stringWithFormat:@"Pack %d", _index + 1];
    NSString *titleLabelText = _product.localizedTitle;
//    NSString *unlockButtonText = [NSString stringWithFormat:@"Unlock Pack %d for $0.99", _index + 1];
    NSString *unlockButtonText = [NSString stringWithFormat:@"Unlock %@ for %@", _product.localizedTitle, price];
    _titleLabel.text = titleLabelText;
    [_unlockButton setTitle:unlockButtonText forState:UIControlStateNormal];
    _previewView.image = [UIImage imageNamed:[NSString stringWithFormat:@"getpack%d.png", _index + 1 ]];
    _scrollView.contentSize = _previewView.frame.size;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    NSLog(@"purchased identifier is111 %@", productIdentifier);
    int itemToPassBack = _index + 1;
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPassBack];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - button methods
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onUnlock:(id)sender {
    
    if(!_product)
    {
        NSLog(@"no product !!!");
        return;
    }
    
    NSLog(@"Buying %@...", _product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:_product];
}

@end
