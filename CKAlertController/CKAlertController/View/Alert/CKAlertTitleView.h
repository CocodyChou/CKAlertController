//
//  CKAlertTitleView.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKAlertTitleView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelOfDetail;

@end
