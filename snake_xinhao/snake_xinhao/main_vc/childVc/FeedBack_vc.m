



//
//  FeedBack_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "FeedBack_vc.h"
#import "feedBackview.h"
#import "XImagePicker.h"
@interface FeedBack_vc ()
@property(nonatomic,strong)  feedBackview *feedview ;
@property(nonatomic,strong)UIImage *photo_img;
@end

@implementation FeedBack_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.title = @"feedback";
    _feedview = [[[NSBundle mainBundle]loadNibNamed:@"feedBackview" owner:self options:nil]firstObject];
    [self.view addSubview:_feedview];
    [_feedview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.height.mas_equalTo(325);
        
    }];
    [[_feedview.photoadd rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self addPhoto];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn  setTitle:@"submit" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self addinfo];
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_feedview.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}
-(void)addPhoto{
    [XImagePicker showImagePickerFromViewController:self allowsEditing:NO finishAction:^(UIImage *image) {
        self.photo_img = image;
        [_feedview.photoadd setImage:image forState:UIControlStateNormal];
    }];
}


-(void)addinfo{
    if (!self.photo_img) {
        [SVProgressHUD showErrorWithStatus:@"please select your photo screenshot"];
        return;
    }
    [SVProgressHUD showWithStatus:@"saving"];
    BmobObject *gameScore = [BmobObject objectWithClassName:@"user"];
    [gameScore setObject:@"hello" forKey:@"name"];
    [gameScore setObject:@"world" forKey:@"age"];
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        [SVProgressHUD showSuccessWithStatus:@"success"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
