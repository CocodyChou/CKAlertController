//
//  CKAlertTitleView.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertTitleView.h"

@implementation CKAlertTitleView

- (void)awakeFromNib
{
    [[NSBundle mainBundle] loadNibNamed:@"CKAlertTitleView" owner:self options:nil];
    [self addSubview:self.contentView];
    
    [self addContentViewContraints];
}

- (void)addContentViewContraints
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    [self addConstraints:@[top, bottom, left, right]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
