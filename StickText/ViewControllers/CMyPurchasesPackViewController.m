//
//  CMyPurchasesPackViewController.m
//  StickText
//
//  Created by Wang on 13-10-26.
//  Copyright (c) 2013年 Cheng Long. All rights reserved.
//

#import "CMyPurchasesPackViewController.h"
#import "CMyPurchasesViewController.h"
#import "CGetMoreCell.h"

@interface CMyPurchasesPackViewController ()

@end

@implementation CMyPurchasesPackViewController

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
    indexArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.all"] == YES) {
        [indexArray addObject:[NSNumber numberWithInt:1]];
        [indexArray addObject:[NSNumber numberWithInt:2]];
        [indexArray addObject:[NSNumber numberWithInt:3]];
        [indexArray addObject:[NSNumber numberWithInt:4]];
    }
    else
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack1"] == YES)
            [indexArray addObject:[NSNumber numberWithInt:1]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack2"] == YES)
            [indexArray addObject:[NSNumber numberWithInt:2]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.pack3"] == YES)
            [indexArray addObject:[NSNumber numberWithInt:3]];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"com.tanya.emotistick.christmas1"] == YES)
            [indexArray addObject:[NSNumber numberWithInt:4]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button methods
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return indexArray.count;
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
    
    int showIndex = [[indexArray objectAtIndex:indexPath.row] intValue];
    
    if (showIndex != 4) {
        NSNumber * number = [NSNumber numberWithInt: showIndex];
        [cell configureWithObject:number];
    }
    else
    {
        [cell.labelStick setText:@"Christmas Pack"];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString* imageName =[NSString stringWithFormat:@"pack %d.png", showIndex];
    [cell.imageStick setImage:[UIImage imageNamed:imageName ]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMyPurchasesViewController* purchasedView = [[[CMyPurchasesViewController alloc] initWithNibName:@"CMyPurchasesViewController" bundle:nil] autorelease];
    int showIndex = [[indexArray objectAtIndex:indexPath.row] intValue];
    purchasedView.selectedPack = showIndex;
    [[self navigationController] pushViewController:purchasedView animated:YES];
}

@end
