//
//  CKAlertView.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKAlertController.h"

@class CKAlertView;
@class CKAlertAction;
@protocol CKAlertViewDelegate <NSObject>

- (void)alertViewDidSelectAction:(CKAlertAction *)action atIndex:(NSInteger)index;

@end

IB_DESIGNABLE
@interface CKAlertView : UIView

@property (weak, nonatomic) id<CKAlertViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSArray *actions;
@property (strong, nonatomic) NSArray *textFieldHandles;
@property (strong, nonatomic, readonly) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;

@property (assign, nonatomic) CKAlertControllerUIStyle preferredUIStyle;

@end
