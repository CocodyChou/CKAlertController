# CKAlertController
使用上模仿UIAlertController，第一版毛坯，第二版将有更多优化

CKAlertController *alertController = [CKAlertController alertControllerWithTitle:@"提示" message:@"消息" preferredStyle:CKAlertControllerStyleAlert];
				
CKAlertAction *cancelAction = [CKAlertAction actionWithTitle:@"默认" style:CKAlertActionStyleCancel handler:^(CKAlertAction *action) {

}];
				
CKAlertAction *confirmAction = [CKAlertAction actionWithTitle:@"留言" style:CKAlertActionStyleDefault handler:^(CKAlertAction *action) {
		content = [alertController.textFields.firstObject text];

}];
				
[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
	  textField.placeholder = content;
}];
				
[alertController addAction:cancelAction];
[alertController addAction:confirmAction];
				
[self presentViewController:alertController animated:YES completion:^{

}];
