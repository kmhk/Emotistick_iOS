//
//  CPunchLineViewController.m
//  StickText
//
//  Created by Mountain on 7/15/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "DBManager.h"

#import "CPunchLineViewController.h"
#import "CShareViewController.h"

@interface CPunchLineViewController ()

@end

@implementation CPunchLineViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"With Punch Line";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _nSelectedIndex = -1;
    [dbManger getPunchSticks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableViewSticks release];
    [_labelCopy release];
    [super dealloc];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count = %d", [dbManger.m_punchSticks count]);
    return [dbManger.m_punchSticks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return [CStickCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = [CStickCell reuseIdentifier];
    CStickCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[CStickCell alloc] init] autorelease];
    }
    
    [cell setDelegate:self];
    
    NSDictionary * dicStick = [dbManger.m_punchSticks objectAtIndex:indexPath.row];
    [cell configureWithObject:dicStick];
    
    [cell setCellIndex:indexPath.row];
    
    if (_nSelectedIndex == indexPath.row) {
        [cell onClickStick:nil];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary * dicStick = [dbManger.m_punchSticks objectAtIndex:indexPath.row];
    
    CShareViewController * viewController = [[[CShareViewController alloc] initWithNibName:@"CShareViewController" bundle:nil] autorelease];
    viewController.index = dicStick[@"index"];  
    viewController.gif_title = dicStick[@"title"];
    viewController.serial = dicStick[@"serial"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - stick cell delegate
- (void) longPressed:(id)object {
    [self.labelCopy setText:@"Copied! Paste into Message."];
}

- (void) stickClicked:(id)object {
    if (_nSelectedIndex != -1) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_nSelectedIndex inSection:0];
        CStickCell * cell = (CStickCell *)[self.tableViewSticks cellForRowAtIndexPath:indexPath];
        [cell setStickCellSelected:NO];
    }
    
    CStickCell * cell = (CStickCell *)object;
    _nSelectedIndex = cell.cellIndex;
}

#pragma mark - button methods
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
