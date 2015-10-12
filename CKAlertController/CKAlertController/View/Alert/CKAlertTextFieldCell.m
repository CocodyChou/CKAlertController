//
//  CKAlertTextFieldCell.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertTextFieldCell.h"

@implementation CKAlertTextFieldCell

- (void)awakeFromNib {
    // Initialization code
//    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.textField.layer.borderWidth = 1.f;
}

- (void)setPreferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle
{
    _preferredUIStyle = preferredUIStyle;
    switch (preferredUIStyle) {
        case CKAlertControllerUIStyleBlack:
        {
            self.textField.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
            [self.textField setValue:[UIColor colorWithRed:120.f / 255 green:120.f / 255 blue:120.f / 255 alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
            break;
        }
        case CKAlertControllerUIStyleWhite:
        {

            break;
        }
        default:
            break;
    }
}

@end
