//
//  CKActionCell.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKActionCell.h"

@implementation CKActionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.labelOfActionTitle.layer.cornerRadius = self.labelOfActionTitle.frame.size.height / 2;
    [self configUI];
}

- (void)configUI
{
    switch (_preferredUIStyle) {
        case CKAlertControllerUIStyleWhite:
        {
            self.selectedBackgroundView = nil;
            switch (_action.style) {
                case CKAlertActionStyleDestructive:
                {
                    [self.labelOfActionTitle setBackgroundColor:[UIColor colorWithRed:244.f / 255 green:57.f / 255 blue:138.f / 255 alpha:1.0f]];
                    self.labelOfActionTitle.textColor = [UIColor whiteColor];
                    self.labelOfActionTitle.layer.borderWidth = 0.f;
                    break;
                }
                case CKAlertActionStyleCancel:
                {
                    [self.labelOfActionTitle setBackgroundColor:[UIColor whiteColor]];
                    self.labelOfActionTitle.layer.borderColor = [UIColor colorWithRed:100.f / 255 green:100.f / 255 blue:100.f / 255 alpha:1.0f].CGColor;
                    [self.labelOfActionTitle setTextColor:[UIColor colorWithRed:100.f / 255 green:100.f / 255 blue:100.f / 255 alpha:1.0f]];
                    self.labelOfActionTitle.layer.borderWidth = 1.f;
                    break;
                }
                case CKAlertActionStyleDefault:
                {
                    [self.labelOfActionTitle setBackgroundColor:[UIColor whiteColor]];
                    self.labelOfActionTitle.layer.borderColor = [UIColor colorWithRed:100.f / 255 green:100.f / 255 blue:100.f / 255 alpha:1.0f].CGColor;
                    [self.labelOfActionTitle setTextColor:[UIColor colorWithRed:100.f / 255 green:100.f / 255 blue:100.f / 255 alpha:1.0f]];
                    self.labelOfActionTitle.layer.borderWidth = 1.f;
                    break;
                }
                case CKAlertActionStyleOK:
                {
                    [self.labelOfActionTitle setBackgroundColor:[UIColor colorWithRed:117.f / 255 green:212.f / 255 blue:110.f / 255 alpha:1.0f]];
                    self.labelOfActionTitle.textColor = [UIColor whiteColor];
                    self.labelOfActionTitle.layer.borderWidth = 0.f;
                }
                default:
                    break;
            }
            break;
        }
        case CKAlertControllerUIStyleBlack:
        {
            UIView *bgView = [UIView new];
            bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
            self.selectedBackgroundView = bgView;
            
            self.labelOfActionTitle.layer.borderWidth = 0;
            self.labelOfActionTitle.backgroundColor = [UIColor clearColor];
            
            switch (_action.style) {
                case CKAlertActionStyleDestructive:
                {
                    [self.labelOfActionTitle setTextColor:[UIColor whiteColor]];
                    break;
                }
                case CKAlertActionStyleCancel:
                {
                    [self.labelOfActionTitle setTextColor:[UIColor colorWithRed:150.f / 255 green:150.f / 255 blue:150.f / 255 alpha:1.0f]];
                    break;
                }
                case CKAlertActionStyleDefault:
                {
                    [self.labelOfActionTitle setTextColor:[UIColor whiteColor]];
                    break;
                }
                case CKAlertActionStyleOK:
                {
                    [self.labelOfActionTitle setTextColor:[UIColor whiteColor]];
                }
                default:
                    break;
            }
            
            break;
        }
            
        default:
            break;
    }

}

- (void)setPreferredUIStyle:(CKAlertControllerUIStyle)preferredUIStyle
{
    _preferredUIStyle = preferredUIStyle;
    [self configUI];
}

- (void)setAction:(CKAlertAction *)action
{
    _action = action;
    self.labelOfActionTitle.text = action.title;
    [self configUI];
}

@end
