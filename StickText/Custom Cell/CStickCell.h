//
//  CStickCell.h
//  StickText
//
//  Created by Mountain on 7/13/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StickCellDelegate <NSObject>

- (void) stickClicked : (id)object;
- (void) longPressed : (id)object;

@optional
- (void) onFavorite : (id)object;

@end

@interface CStickCell : UITableViewCell {
    
}

@property (nonatomic) BOOL cellSelected;
@property (nonatomic) int cellIndex;
@property (retain, nonatomic) NSDictionary * dicStick;

@property (assign, nonatomic) id <StickCellDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIView *content_;
@property (retain, nonatomic) IBOutlet UIImageView *imageStick;
@property (retain, nonatomic) IBOutlet UIImageView *imageBack;
@property (retain, nonatomic) IBOutlet UILabel *labelStick;
@property (retain, nonatomic) IBOutlet UIButton *btnFavorite;
@property (retain, nonatomic) IBOutlet UIButton *btnStickImage;


+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;
+ (float) height;

- (void) configureWithObject:(NSObject *)object;
- (IBAction)onFavorite:(id)sender;
- (IBAction)onClickStick:(id)sender;
- (void) setStickCellSelected:(BOOL)cellSelected_;
@end
