//
//  CKAlertControllerTransitionController.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "CKAlertControllerTransitionController.h"

@interface CKAlertControllerTransitionController ()
@end

@implementation CKAlertControllerTransitionController

+ (instancetype)defaultTransitionController
{
    static CKAlertControllerTransitionController *controller = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [CKAlertControllerTransitionController new];
    });
    
    return controller;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.type) {
        case CKAlertTransitionAnimationTypeDismiss:
        case CKAlertTransitionAnimationTypePop:
        {
            [self hideAnimate:transitionContext];
            break;
        }
        case CKAlertTransitionAnimationTypePresent:
        case CKAlertTransitionAnimationTypePush:
        {
            [self showAnimate:transitionContext];
            break;
        }
        default:
            break;
    }
}

- (void)showAnimate:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //Get references to the view hierarchy
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toViewController.view.alpha = 0.0f;
    [containerView addSubview:toViewController.view];
    
    CGAffineTransform scaleT = CGAffineTransformMakeScale(2.f, 2.f);
    toViewController.view.transform = CGAffineTransformTranslate(scaleT, 0, 0);
    
    //Animate using keyframe animations
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        toViewController.view.alpha = 1.0f;
        CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0f, 1.0f);
        toViewController.view.transform = CGAffineTransformTranslate(scaleT, 0, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)hideAnimate:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //Get references to the view hierarchy
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //Animate using keyframe animations
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        fromViewController.view.alpha = .0f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
