//
//  Zoushi_Vc.m
//  Caipiao_app
//
//  Created by 信昊 on 17/6/23.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zoushi_Vc.h"
#import "Zhonglei_Cell.h"
#import "ZoushiDetail_Vc.h"
#import "PYSearch.h"

@interface Zoushi_Vc ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,retain)NSArray *Image_arr;
@property(nonatomic,retain)NSArray *Url_arr;
@property(nonatomic,retain)NSArray *Title_arr;
@property(nonatomic,retain)NSArray *description_arr;
@property(nonatomic,retain)NSMutableArray *datasouce;



@end

@implementation Zoushi_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"彩票种类"];
//    [self loadata];
    [self initData];
    [self initUI];
    
    UIBarButtonItem *SearchBtn = [QDWTools initBarButtonItemWithText:@"" Withfont:0 WithTextColor:nil WithBackColor:nil WithImg:IMG(@"我的客户列表搜索按钮") WithBackImage:nil WithFrame:CGRectMake(0, 0, 18.5, 20) WithTarget:self WithAction:@selector(SearchAction)];
    UIBarButtonItem *fixspace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[SearchBtn,fixspace];


    // Do any additional setup after loading the view.
}

#pragma mark -- 上面的搜索
-(void)SearchAction{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"七乐彩", @"双色球", @"六场半全场", @"四场进球彩", @"十四场胜负彩(任9)", @"快三", @"快乐十分(动物总动员)", @"赛车(pk10)", @"群英会", @"泳坛夺金", @"福彩25选5", @"体彩31选7", @"深圳风采", @"福彩p62"];
    NSArray *hot_url =@[@"qxc",@"ssq",@"zcbqc",@"zcjqc",@"zcsfc",@"ahk3",@"gdklsf",@"bjpk10",@"sdqyh",@"sxrytdj",@"ahfc25x5",@"fjtc36x7",@"gdszfc",@"hljfcp62"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索彩票" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
        ZoushiDetail_Vc *vc = [[ZoushiDetail_Vc alloc] init];
        
        for (NSInteger i = 0; i < hotSeaches.count; i++) {
            if ([searchText isEqual:hotSeaches[i]]) {
                vc.style_url = hot_url[i];
            }
        }
        vc.title_text = searchText;
        [searchViewController.navigationController pushViewController:vc animated:YES];
    }];
    
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
       // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
    
    [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"由于本产品第一次上线，目前还在改进阶段，目前仅支持查询热门彩票业务，后面的版本会增加各种查询服务，敬请期待。" WithView:searchViewController];

    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


//sh11x5   bjkl8
-(void)initData{
    self.datasouce = [[NSMutableArray alloc]init];
    
    self.Image_arr = @[@"image0",@"image12",@"image2",@"image3",@"image4",@"image5",@"image6",@"image7",@"image11",@"image9"];
    self.Url_arr = @[@"sh11x5",@"pl3",@"xjssc",@"fjtc31x7",@"thffc5",@"hunxysc",@"cqklsf",@"shssl",@"hebk3",@"shssl"];
    self.Title_arr = @[@"11选5",@"排列3",@"时时彩",@"体彩",@"时时彩",@"幸运赛车",@"快乐十分",@"幸运农场",@"快三",@"时时乐"];
    self.description_arr = @[@"每天81期，08:41起每10分钟一期",@"每天179期，09:05起每5分钟一期",@"每天84期，09:30起每10分钟一期",@"每周一、三、五、日的20:00开奖",@"每天72期，09:44起每10分钟一期",@"每天84期，09:10起每10分钟一期",@"每天84期，09:35起每10分钟一期",@"每天97期，00:05起每10、10分钟一期",@"每天73期，09:45起每10分钟一期",@"每天23期，10:30起每30分钟一期"];
}
-(void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Zhonglei_Cell" bundle:nil] forCellReuseIdentifier:@"Zhonglei_Cell"];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Zhonglei_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Zhonglei_Cell"];
    
    cell.Title.text = self.Title_arr[indexPath.section];
    cell.IconView.image = IMG(self.Image_arr[indexPath.section]);
    cell.descrition_label.text = self.description_arr[indexPath.section];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZoushiDetail_Vc *vc = [[ZoushiDetail_Vc alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.title_text = self.Title_arr[indexPath.section];
    vc.style_url = self.Url_arr[indexPath.section];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
//-(void)loadata{
//    NSDictionary *dic = @{@"code":@"hubk3",@"endTime":@"2017-5-09 21:21:40",@"count":@"10"};
//    @weakify(self)
//    [[NetManager shareManager]postNetWithStyle:Duoqi_Style Withdic:dic Success:^(NSDictionary *data) {
//        @strongify(self)
//        if ([[NSString stringWithFormat:@"%@",data[@"showapi_res_code"]] isEqual:@"0"]) {
//            NSDictionary *result_dic = data[@"showapi_res_body"];
//            self.datasouce = [Caipiao_Model mj_objectArrayWithKeyValuesArray:result_dic[@"result"]];
//            
//            [self.tableView reloadData];
//        }else{
//            
//        }
//
//        
//    }];
//    
//}
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
