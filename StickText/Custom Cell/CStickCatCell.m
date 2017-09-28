//
//  CStickCatCell.m
//  StickText
//
//  Created by Mountain on 7/13/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "CStickCatCell.h"

@implementation CStickCatCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName {
    return @"CStickCatCell";
}

+ (float) height {
    return 70.0f;
}

- (id)init {
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    NSString * identifier = [[self class] reuseIdentifier];
    
    if ((self = [super initWithStyle:style reuseIdentifier:identifier])) {
        NSString * nibName = [[self class] nibName];
        if (nibName) {
            [[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                        options:nil];
            NSAssert(self.content_ != nil, @"NIB file loaded but content property not set");
            [self.contentView addSubview:self.content_];
        }
    }
    
    return self;
}

- (void) configureWithObject:(NSObject *)object {
    NSDictionary * dicStick = (NSDictionary *) object;
    [self.labelStick setText:dicStick[@"title"]];
    [self.imageIcon setImage:[UIImage imageNamed:dicStick[@"image"]]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initial ization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc {
    [_content_ release];
    [_labelStick release];
    [_imageIcon release];
    [super dealloc];
}

@end
