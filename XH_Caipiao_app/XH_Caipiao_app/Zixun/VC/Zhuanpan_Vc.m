
//
//  Zhuanpan_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zhuanpan_Vc.h"
#import "NYWheel.h"
@interface Zhuanpan_Vc ()
@property(nonatomic,strong)NYWheel *wheel;

@property(nonatomic,retain)NSArray *datasource;

@property(nonatomic,assign)NSInteger numIndex;
@end

@implementation Zhuanpan_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addNavBarTitle:@"疯狂大抽奖"];
    
    NYWheel *wheel = [NYWheel wheel];
    wheel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    [self.view addSubview:wheel];
    self.wheel = wheel;
    
    UIButton *start_btn = [QDWTools initBtnWithName:@"开始" Withfont:15 WithImag:IMG(FormatCicle_btn_ImageName) WithTextColor:_COLOR_RGB(0xffffff) WithBackColor:nil WithCornerRadius:5 WithFrame:CGRectMake(10, MaxY(self.wheel)+20, 150, 35)];
    
    UIButton *stop_btn = [QDWTools initBtnWithName:@"结束" Withfont:15 WithImag:IMG(FormatCicle_btn_ImageName) WithTextColor:_COLOR_RGB(0xffffff) WithBackColor:nil WithCornerRadius:5 WithFrame:CGRectMake(SCREEN_WIDTH-160, MaxY(self.wheel)+20, 150, 35)];
    [self.view addSubview:stop_btn];
    [self.view addSubview:start_btn];
    @weakify(self)
    [[start_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [self.wheel startRotating];
    }];
    [[stop_btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self)
        [self.wheel stopRotating];
    }];
    
    self.wheel.block = ^(UIButton *btn){
        int x = arc4random() % 20;
    @strongify(self)
        if (self.numIndex == 0) {
                  [QDWTools ShowTishiAlertControllerWithTitle:@"恭喜" AndDetial:self.datasource[x] WithView:self];
        }else{
            [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"只能获得一次" WithView:self];
        }
        self.numIndex++;
        
    };
    
    // Do any additional setup after loading the view.
}
-(void)initData{
    self.numIndex = 0;
    self.datasource = @[@"恭喜您获取了 5元流量券",@"恭喜您获取了 7元流量券",@"恭喜您获取了 1元流量券",@"恭喜您获取了 3元流量券",@"恭喜您获取了 10元流量券",@"恭喜您获取了 8元流量券",@"恭喜您获取了 3元流量券",@"恭喜您获取了 8元流量券",@"恭喜您获取了 11元流量券",@"恭喜您获取了 20元流量券",@"恭喜您获取了 10元流量券",@"恭喜您获取了 30元流量券",@"恭喜您获取了 10元流量券",@"恭喜您获取了 7元流量券",@"恭喜您获取了 12元话费",@"恭喜您获取了 14元话费",@"恭喜您获取了 17元流量券",@"恭喜您获取了 19元流量券",@"恭喜您获取了 12元流量券",@"恭喜您获取了 19元话费",];
    
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
