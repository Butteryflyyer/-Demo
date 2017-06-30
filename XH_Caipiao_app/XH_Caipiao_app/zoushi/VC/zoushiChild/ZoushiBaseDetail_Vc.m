//
//  ZoushiNewDetail_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/30.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "ZoushiBaseDetail_Vc.h"
#import "LXTrendView.h"
@interface ZoushiBaseDetail_Vc ()

@property(nonatomic,retain)NSMutableArray *datasouce;

@property(nonatomic,retain)NSMutableArray *mu_datasource;

@property(nonatomic,strong)LXTrendView *Trend_View;

@end

@implementation ZoushiBaseDetail_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self addNavBarTitle:self.title_text];

    
    self.Trend_View = [[LXTrendView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHight)];
    [self.view addSubview:self.Trend_View];
    
    self.Time_Date = 0;
    [self loadata];

    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.Time_Date = 0;
    [self loadata];
}

-(void)loadata{

    NSDictionary *dic = @{@"code":self.style_url,@"endTime":[QDWTools getNowTimeWith:self.Time_Date],@"count":@"10"};
    @weakify(self)
    [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
        @strongify(self)
        self.datasouce = [[NSMutableArray alloc]init];
        self.mu_datasource = [[NSMutableArray alloc]init];
        
        if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
            NSDictionary *result_dic = data[@"showapi_res_body"];
          self.mu_datasource = [Caipiao_Model mj_objectArrayWithKeyValuesArray:result_dic[@"result"]];
            
            for (Caipiao_Model *model in self.mu_datasource) {
                
                NSString *str = [model.openCode substringFromIndex:model.openCode.length-1];
                
                [self.datasouce addObject:str];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.Trend_View.fillDatas = self.datasouce;
                [self.Trend_View setNeedsDisplay];
            });
            
        }else{
            
        }
        
        
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
