//
//  CKActionCell.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKAlertController.h"

@interface CKActionCell : UICollectionViewCell

@property (nonatomic, weak) CKAlertAction *action;
@property (weak, nonatomic) IBOutlet UILabel *labelOfActionTitle;

@property (assign, nonatomic) CKAlertControllerUIStyle preferredUIStyle;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *leftLine;

@end
