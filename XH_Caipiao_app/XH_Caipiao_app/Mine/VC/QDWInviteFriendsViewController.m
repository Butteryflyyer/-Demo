//
//  QDWInviteFriendsViewController.m
//  QianDaoWeiApp
//
//  Created by 融联 on 16/5/12.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWInviteFriendsViewController.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+QRCodeWithCImage.h"
#import "MinePageManager.h"
#import "QDWInviteFriendModel.h"

@interface QDWInviteFriendsViewController ()

@property (weak, nonatomic  ) IBOutlet UIImageView          *imageView;
@property (weak, nonatomic  ) IBOutlet UILabel              *inviteNum;
@property (weak, nonatomic  ) IBOutlet UILabel              *userNum;
@property (weak, nonatomic  ) IBOutlet UILabel              *RenZhengNum;

@property (nonatomic, copy  ) NSString             *codeurlString;

@property (nonatomic, strong) QDWInviteFriendModel *model;

@end


@implementation QDWInviteFriendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self creatQRCode];

}

- (void)setupNav {
    
    [self addNavBarTitle:@"邀请好友"];
//
//    self.navigationItem.rightBarButtonItem            = [[UIBarButtonItem alloc] initWithTitle:@"邀请" style:UIBarButtonItemStyleDone target:self action:@selector(click:)];
    self.navigationController.navigationBar.tintColor = _COLOR_RGB(0xf5f5f5);
}

- (void)creatQRCode {
   
    [MinePageManager CreatQRCodeWithUrl:QDWCreatQRCode_URL SuccessBlock:^(id data) {
        if (data) {
          //  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          [self creatQRCodeWithString:data];

         [self inviteFriend];
        }
    } FailureBlock:^(id data) {
        NSLog(@"fail");
    }];
}

- (void)creatQRCodeWithString:(NSString *)codeString {

    if (codeString.length == 0 || codeString == nil) {
        return;
    }
    NSString *urlStr     = [NSString stringWithFormat:@"%@%@%@",QDWBASE_URL, QDWselfCenter_URL, codeString];

    self.codeurlString   = codeString;

    DLOG(@"%@",urlStr);
    // 1.创建滤镜对象
    CIFilter *filter     = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 2.恢复默认设置
    [filter setDefaults];

    // 3.给滤镜设置数据
    NSData *data         = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];

    // 4.获取生成好的二维码
    CIImage *outputImage = [filter outputImage];

    // 5.将二维码显示在imageView上
    self.imageView.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}


- (void)inviteFriend {

    NSDictionary *dict = @{@"id":[QDWUser shareManager].Userid};
    
        [MinePageManager InviteFriendUrl:QDWInviteFriend_URL WithDict:dict SuccessBlock:^(id data) {
       
        if (data) {
            _model = [QDWInviteFriendModel mj_objectWithKeyValues:data];
            [self setModel];
        }
    } FailureBlock:^(id data) {
        
    }];

}


- (void)setModel {

    _inviteNum.text   = self.model.userNum;
    _userNum.text     = self.model.billNum;
    _RenZhengNum.text = self.model.userRegisterNum;
    
}


- (void)click:(UIButton *)rightBtn {
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",QDWBASE_URL, QDWselfCenter_URL,self.codeurlString];

    DLOG(@"%@",url);



}



@end
