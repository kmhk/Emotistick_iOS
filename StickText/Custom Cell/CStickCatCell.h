//
//  CStickCatCell.h
//  StickText
//
//  Created by Mountain on 7/13/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CStickCatCell : UITableViewCell {
    
}

@property (retain, nonatomic) IBOutlet UIView *content_;
@property (retain, nonatomic) IBOutlet UILabel *labelStick;
@property (retain, nonatomic) IBOutlet UIImageView *imageIcon;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (float) height;

- (void) configureWithObject:(NSObject *)object;

@end
