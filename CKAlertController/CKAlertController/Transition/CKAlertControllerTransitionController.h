//
//  CKAlertControllerTransitionController.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    CKAlertTransitionAnimationTypePresent,
    CKAlertTransitionAnimationTypeDismiss,
    CKAlertTransitionAnimationTypePush,
    CKAlertTransitionAnimationTypePop
} CKAnimationType;

@interface CKAlertControllerTransitionController : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)defaultTransitionController;

@property (nonatomic, assign) CKAnimationType type;

@end
