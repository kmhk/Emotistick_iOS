//
//  CMoreAppsViewController.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMoreAppsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property (retain, nonatomic) IBOutlet UITableView *tableViewApps;

- (IBAction)onBack:(id)sender;

@end
