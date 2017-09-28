//
//  CGetMoreCell.m
//  StickText
//
//  Created by Mountain on 8/01/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "DBManager.h"

#import "UIImage+animatedGIF.h"

#import "CGetMoreCell.h"

@implementation CGetMoreCell

@synthesize dicStick;

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName {
    return @"CGetMoreCell";
}

+ (float) height {
    return 68.0f;
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
    NSNumber * number = (NSNumber *)object;
    [self.labelStick setText:[NSString stringWithFormat:@"Pack %d", [number integerValue]]];
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
    [_imageStick release];
    [super dealloc];
}

@end
