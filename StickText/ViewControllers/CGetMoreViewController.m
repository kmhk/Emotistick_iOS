//
//  CGetMoreViewController.m
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "CGetMoreViewController.h"
#import "CGetPackViewController.h"
#import "CGetMoreCell.h"
#import "DBManager.h"

@interface CGetMoreViewController ()

@end

@implementation CGetMoreViewController
@synthesize myProducts;
@synthesize refreshControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Get More";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self.tableViewPacks addSubview:self.refreshControl];
    [self.refreshControl beginRefreshing];
    [self reload];
    
    
    myPriceFormatter = [[NSNumberFormatter alloc] init];
    [myPriceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [myPriceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    boolArray = [[NSMutableArray alloc] init];
    [boolArray addObject:[NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.all"]]];
    [boolArray addObject:[NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack1"]]];
    [boolArray addObject:[NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack2"]]];
    [boolArray addObject:[NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack3"]]];
    [boolArray addObject:[NSNumber numberWithBool:[[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.christmas1"]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableViewPacks release];
    [super dealloc];
}

#pragma mark - button methods
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onRemoveAds:(id)sender {
    SKProduct *product = self.myProducts[0];
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
}

- (IBAction)onRestoreIAP:(id)sender {    
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myProducts.count - 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return [CGetMoreCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = [CGetMoreCell reuseIdentifier];
    CGetMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[CGetMoreCell alloc] init] autorelease];
    }
    
    NSNumber * number = [NSNumber numberWithInt:indexPath.row + 1 ];
    //[cell configureWithObject:number];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }*/

    SKProduct * product = (SKProduct *) self.myProducts[indexPath.row + 1];
    [myPriceFormatter setLocale:product.priceLocale];
    NSString* imageName =[NSString stringWithFormat:@"pack %d.png", indexPath.row + 1];
    [cell.imageStick setImage:[UIImage imageNamed:imageName ]];
    [cell.labelStick setText:product.localizedTitle];

    if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier] ||
        [[RageIAPHelper sharedInstance] productPurchased:@"com.tanya.emotistick.all"]) {
        UIImageView* checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbutton.png" ]];
        checkImageView.frame = CGRectMake(0, 0, 37, 37);
        cell.accessoryView = checkImageView;
    } else {
        /*
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 50, 37);
        [buyButton setBackgroundImage:[UIImage imageNamed:@"buybutton.png"] forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row + 1;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;*/
    }

    return cell;
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = self.myProducts[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKProduct* product = self.myProducts[ indexPath.row+1 ];
    
    if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier] ||
        [[RageIAPHelper sharedInstance] productPurchased:@"com.tanya.emotistick.all"]) {
        NSLog(@"This product is purchased already!");
    }
    else {
        CGetPackViewController* packView = [[CGetPackViewController alloc] init];
        packView.delegate = self;
        packView.index = indexPath.row;
        packView.product = product;
        [self.navigationController pushViewController:packView animated:YES];
    }
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    NSLog(@"purchased identifier is %@", productIdentifier);
    [self.myProducts enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            //[self.tableViewPacks reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableViewPacks reloadData];
            
            if( [[boolArray objectAtIndex:idx] boolValue] == NO && idx != 0)
            {
                [dbManger insertPacks:idx];
                [boolArray replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:YES]];
            }
            else if ([[boolArray objectAtIndex:idx] boolValue] == NO && idx == 0)
            {
                for (int i = 1; i<= 4; i++) {
                    if ([[boolArray objectAtIndex:i] boolValue] == NO) {
                        [dbManger insertPacks:i];
                        [boolArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
                    }
                }
            }
            
            *stop = YES;
        }
    }];
    
}
- (void)reload {
    if (self.myProducts) {
        [self.myProducts release];
    }
    self.myProducts = [[NSMutableArray alloc] init];
   
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            //self.myProducts = products;
            
            NSMutableArray* productOrder = [[NSMutableArray alloc] initWithObjects:
            @"com.tanya.emotistick.all",
            @"com.tanya.emotistick.pack1",
            @"com.tanya.emotistick.pack2",
            @"com.tanya.emotistick.pack3",
            @"com.tanya.emotistick.christmas1",nil];
            
            if (productOrder.count != products.count) {
                NSLog(@"error ! productOrder count is not equal to products.count !");
            }
            
            for (int i = 0; i< products.count; i++)
            for (int j = 0; j< products.count; j++){
                
                NSString* PID_order = [productOrder objectAtIndex:i];
                SKProduct *product = products[j];
                if ([PID_order isEqualToString:product.productIdentifier]) {
                    [self.myProducts addObject:product];
                }
                
            }
            [productOrder release];
            [self.tableViewPacks reloadData];
            
            SKProduct *product = self.myProducts[0];
            [myPriceFormatter setLocale:product.priceLocale];
            NSString* price = [myPriceFormatter stringFromNumber:product.price];            
            NSString *unlockAllButtonText = [NSString stringWithFormat:@"Unlock All Packs for %@", price];
            [_unlockAllButton setTitle:unlockAllButtonText forState:UIControlStateNormal];
        }
        [self.refreshControl endRefreshing];
        
    }];
     [self.tableViewPacks reloadData];
}

- (void)addItemViewController:(CGetPackViewController *)controller didFinishEnteringItem:(int)item
{
    NSLog(@"This was returned from ViewControllerB %d",item);
    [self.tableViewPacks reloadData];
    [dbManger insertPacks:item];
}

@end
