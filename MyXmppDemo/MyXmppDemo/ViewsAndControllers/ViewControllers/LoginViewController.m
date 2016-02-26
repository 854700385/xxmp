//
//  LoginViewController.m
//  
//
//  Created by 张广洋 on 15/11/15.
//
//

#import "LoginViewController.h"

#import "UIFunction.h"

#import "XMPPManager.h"

@interface LoginViewController ()

//域
@property (weak, nonatomic) IBOutlet UITextField *doMainNameTF;
//用户名字
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
//用户密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置默认登陆服务器的域
    self.doMainNameTF.text=@"zhangguangyangdemacbook-pro.local";
}

#pragma mark - 按钮触发的各种事件 -

- (IBAction)loginBtnClicked:(id)sender {
    XMPPManager * manager=[XMPPManager manager];
    manager.userName=self.userNameTF.text;
    manager.password=self.passwordTF.text;
    manager.doMainName=self.doMainNameTF.text;
    [manager loginWithCallBack:^(BOOL Success, NSError * error) {
        if (Success) {
            NSLog(@"哎哟，登陆成功咯");
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@"哎哟，登陆失败");
        }
    }];
}

- (IBAction)registerBtnClicked:(id)sender {
    XMPPManager * manager=[XMPPManager manager];
    manager.userName=self.userNameTF.text;
    manager.password=self.passwordTF.text;
    manager.doMainName=self.doMainNameTF.text;
    [manager registerWithCallBack:^(BOOL Success, NSError * error) {
        if (Success) {
            NSLog(@"哎哟，注册成功咯");
            [UIFunction showAlertWithTitle:nil Message:@"注册成功咯！" viewController:self];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@"哎哟，注册失败");
        }
    }];
}

#pragma mark - 其他事件 -

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //隐藏键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
