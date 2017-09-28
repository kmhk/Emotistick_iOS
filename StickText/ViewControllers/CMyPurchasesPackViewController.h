//
//  CMyPurchasesPackViewController.h
//  StickText
//
//  Created by Wang on 13-10-26.
//  Copyright (c) 2013年 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMyPurchasesPackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* indexArray;
}
@property (retain, nonatomic) IBOutlet UITableView *tableViewPacks;

- (IBAction)onBack:(id)sender;
- (int) getRowCount;
@end
