//
//  CKAlertTextFieldCell.h
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKAlertController.h"
@interface CKAlertTextFieldCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (assign, nonatomic) CKAlertControllerUIStyle preferredUIStyle;

@end
