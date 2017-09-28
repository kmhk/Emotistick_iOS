//
//  CMyPurchasesViewController.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CStickCell.h"

@interface CMyPurchasesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, StickCellDelegate>{
            int             _nSelectedIndex;
}
@property (assign) int selectedPack;
@property (retain, nonatomic) IBOutlet UITableView *tableViewSticks;
@property (retain, nonatomic) IBOutlet UILabel *labelCopy;
- (IBAction)onBack:(id)sender;

@end

