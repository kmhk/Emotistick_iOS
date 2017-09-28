//
//  CAppsCell.h
//  StickText
//
//  Created by Mountain on 7/17/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAppsCell : UITableViewCell {
    
}

@property (retain, nonatomic) IBOutlet UIView *content_;
@property (retain, nonatomic) IBOutlet UILabel *labelStick;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (float) height;

- (void) configureWithObject:(NSObject *)object;

@end
