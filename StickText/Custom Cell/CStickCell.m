//
//  CStickCell.m
//  StickText
//
//  Created by Mountain on 7/13/13.
//  Copyright (c) 2013 Cheng Long. All rights reserved.
//

#import "DBManager.h"

#import "UIImage+animatedGIF.h"

#import "CStickCell.h"

@implementation CStickCell

@synthesize dicStick;

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName {
    return @"CStickCell";
}

+ (float) height {
    return 103.0f;
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
        
        UILongPressGestureRecognizer * longPressRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)] autorelease];
        longPressRecognizer.minimumPressDuration = 1.0f;
        longPressRecognizer.allowableMovement = 0.0f;
        [self.btnStickImage addGestureRecognizer:longPressRecognizer];
    }
    
    return self;
}

- (void) configureWithObject:(NSObject *)object {
    
    
    [self.imageBack setImage:[[UIImage imageNamed:@"punch_line_cell.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    
    dicStick = (NSDictionary *)object;
    
    self.cellSelected = NO;
    if ([dicStick[@"category"] isEqualToString:@"0"]) {
        self.labelStick.text = dicStick[@"title"];
    }
    else
    {
        self.labelStick.text = nil;
    }
//    self.labelStick.text = dicStick[@"title"];
    
    NSString * imageName = [NSString stringWithFormat:@"title_%@.png", dicStick[@"index"]];
 //NSLog(@"dickStick is %@", dicStick[@"index"]);
    self.imageStick.image = [UIImage imageNamed:imageName];
    
    if ([dicStick[@"favorite"] boolValue]) {
        [self.btnFavorite setSelected:YES];
    }
    else {
        [self.btnFavorite setSelected:NO];
    }
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
    [_btnFavorite release];
    [_imageStick release];
    [_btnStickImage release];
    [_imageBack release];
    [super dealloc];
}

#pragma mark - button methods
- (IBAction)onFavorite:(id)sender {
    [self.btnFavorite setSelected:!self.btnFavorite.selected];
    NSString * favorite;
    if (self.btnFavorite.selected) {
        favorite = @"1";
    }
    else {
        favorite = @"0";
    }
    
    [dbManger updateStickFavorite:dicStick[@"serial"] favorite:favorite];
    
    if ([self.delegate respondsToSelector:@selector(onFavorite:)]) {
        [self.delegate onFavorite:self];
    }
}

- (IBAction)onClickStick:(id)sender {
    if (self.cellSelected) {
        return;
    }
    
    self.cellSelected = YES;
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:dicStick[@"index"] withExtension:@"gif"];
    self.imageStick.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
    if ([self.delegate respondsToSelector:@selector(stickClicked:)]) {
        [self.delegate stickClicked:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(longPressed:)]) {
        [self.delegate longPressed:self];
    }
}

#pragma mark - gesture handler
- (void) onLongPress:(id) sender {
//    if ([self.delegate respondsToSelector:@selector(longPressed:)]) {
//        [self.delegate longPressed:self];
//    }
}

- (void) setStickCellSelected:(BOOL)cellSelected_ {
    self.cellSelected = cellSelected_;
    
    if (!self.cellSelected) {
        NSString * imageName = [NSString stringWithFormat:@"title_%@.png", dicStick[@"index"]];
        self.imageStick.image = [UIImage imageNamed:imageName];
    }
}

@end
