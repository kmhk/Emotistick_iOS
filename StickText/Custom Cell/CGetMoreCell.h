//
//  CGetMoreCell.h
//  StickText
//
//  Created by Mountain on 8/01/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGetMoreCell : UITableViewCell {
    
}

@property (nonatomic) BOOL cellSelected;
@property (nonatomic) int cellIndex;
@property (retain, nonatomic) NSDictionary * dicStick;

@property (retain, nonatomic) IBOutlet UIView *content_;
@property (retain, nonatomic) IBOutlet UIImageView *imageStick;
@property (retain, nonatomic) IBOutlet UILabel *labelStick;
//@property (retain, nonatomic) IBOutlet UIImageView *accesoryStick;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (float) height;

- (void) configureWithObject:(NSObject *)object;

@end
