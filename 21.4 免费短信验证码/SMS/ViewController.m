//
//  ViewController.m
//  SMS
//
//  Created by 史昕 on 16/5/18.
//  Copyright © 2016年 tongxunlu. All rights reserved.
//

#import "ViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)getSMS:(id)sender {
    //获取验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS
                            phoneNumber:self.phoneTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error) {
                                     if (error == nil) {
                                         self.resultLabel.text = @"发送成功";
                                         
                                         self.phoneTextField.userInteractionEnabled = NO;
                                     }else{
                                         self.resultLabel.text = @"failue";
                                         NSLog(@"%@",error);
                                     }
                                 }];
    
    
    
}

- (IBAction)verifySMS:(id)sender {
    //输入验证码获取结果
    
    [SMSSDK commitVerificationCode:self.codeTextField.text
                       phoneNumber:self.phoneTextField.text
                              zone:@"86"
                            result:^(NSError *error) {
                                NSLog(@"%@",error);
                                if (error == nil) {
                                    self.resultLabel.text = @"验证成功";
                                }else {
                                    NSString *errorMsg = error.userInfo[@"commitVerificationCode"];
                                    self.resultLabel.text = errorMsg;
                                }
                                
                            }
     ];
    
    
    self.phoneTextField.userInteractionEnabled = YES;
}

@end
