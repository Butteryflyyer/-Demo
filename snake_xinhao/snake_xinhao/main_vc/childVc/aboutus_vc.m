
//
//  aboutus_vc.m
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/29.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "aboutus_vc.h"

@interface aboutus_vc ()

@end

@implementation aboutus_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"about us";
//    UILabel *about = [[UILabel alloc]initWithFrame:CGRectMake(10, 20,SCREEN_WIDTH-20, SCREEN_HEIGHT-20)];
//    about.font = FontBold(20);
//    [self.view addSubview:about];
//    about.numberOfLines = 0;
//    about.textAlignment = NSTextAlignmentLeft;
//
//    about.text = @"[info] Remember the snake on the black and white mobile phone? Miss to play on a few?Now you don't have to wait, you can also play snake in iPhone, the same classic, different operation feel,With the advantage of touch screen, the fingers glide gently to control the snake's way forward.The eternal classic rules, not to eat beans, long body, don't hit the wall, do not eat its own tail, the snake will speed along with the length of accelerating Support the global rankings, you can compete with each other";
    
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    textview.text = @"[info] Remember the snake on the black and white mobile phone? Miss to play on a few?Now you don't have to wait, you can also play snake in iPhone, the same classic, different operation feel,With the advantage of touch screen, the fingers glide gently to control the snake's way forward.The eternal classic rules, not to eat beans, long body, don't hit the wall, do not eat its own tail, the snake will speed along with the length of accelerating Support the global rankings, you can compete with each other";
    [self.view addSubview:textview];
    textview.font = FontBold(15);
    
    // Do any additional setup after loading the view.
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
