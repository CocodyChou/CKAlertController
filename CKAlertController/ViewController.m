//
//  ViewController.m
//  CKAlertController
//
//  Created by 仇弘扬 on 15/10/10.
//  Copyright © 2015年 Cocody. All rights reserved.
//

#import "ViewController.h"
#import "CKAlertController/CKAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    [self showSystem];
}
- (IBAction)ck:(id)sender {
    [self showCK];
}

- (void)showCK
{
    CKAlertController *alert = [CKAlertController alertControllerWithTitle:@"test" message:@"msgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfjmsgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfjmsgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfjmsgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;" preferredStyle:CKAlertControllerStyleAlert preferredUIStyle:CKAlertControllerUIStyleBlack];
    
    CKAlertAction *action = [CKAlertAction actionWithTitle:@"cancel" style:CKAlertActionStyleCancel handler:^(CKAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    CKAlertAction *action2 = [CKAlertAction actionWithTitle:@"delete" style:CKAlertActionStyleDestructive handler:^(CKAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action2];
    
    CKAlertAction *action3 = [CKAlertAction actionWithTitle:@"default" style:CKAlertActionStyleDefault handler:^(CKAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action3];
    
    CKAlertAction *action4 = [CKAlertAction actionWithTitle:@"OK" style:CKAlertActionStyleOK handler:^(CKAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action4];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test1";
    }];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)showSystem
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"test" message:@"msgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfjmsgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfjmsgaslkdfjalskdjf laskdjf laksjdf ;lasjdf ;lajsdf;l asjdf;al skjd;falskdj falsdkjf a;lsdjf a;lksdjf alskdjf ;lasdkfj" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action2];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action3];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action4];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action5];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
