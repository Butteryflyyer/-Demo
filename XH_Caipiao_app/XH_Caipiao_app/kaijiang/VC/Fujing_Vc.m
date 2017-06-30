



//
//  Fujing_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/27.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Fujing_Vc.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "Fujin_Cell.h"
#import "LocationMap_Vc.h"
@interface Fujing_Vc ()<AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AMapSearchAPI *search;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,retain)NSMutableArray *datasource;
@end

@implementation Fujing_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:@"附近的站点"];
    [self initUI];
    
  
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    if ([QDWUser shareManager].latitude == 0) {
        
        [QDWTools ShowTishiAlertControllerWithTitle:@"温馨提示" AndDetial:@"获取地理位置失败，搜索失败" WithView:self];
        
    }else{
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:[QDWUser shareManager].latitude longitude:[QDWUser shareManager].longitude];
        request.keywords            = @"彩票";
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = YES;
        
        [self.search AMapPOIAroundSearch:request];
        
  
    }
    
    
    
    // Do any additional setup after loading the view.
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    self.datasource = [[NSMutableArray alloc]init];
    
    if (response.pois.count == 0)
    {
        return;
    }
    if (response.pois.count >0) {
        
        self.datasource = [NSMutableArray arrayWithArray:response.pois];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }
    [SVProgressHUD dismiss];

}
-(void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 10) style:UITableViewStylePlain];
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //    self.QDWTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _COLOR_RGB(0xf5f5f5);
    
    [self.tableView setSeparatorColor:_COLOR_RGB(0xf1f1f1)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Fujin_Cell" bundle:nil] forCellReuseIdentifier:@"Fujin_Cell"];
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        
        [SVProgressHUD showWithStatus:@"加载中"];
        
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
        request.keywords            = @"彩票";
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = YES;
        
        [self.search AMapPOIAroundSearch:request];

        [self.tableView.mj_header endRefreshing];
        
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Fujin_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Fujin_Cell"];
    
    if (self.datasource.count > 0) {
        
        AMapPOI *poi = self.datasource[indexPath.row];
        
        cell.name_label.text = poi.name;
        cell.distance_label.text = [NSString stringWithFormat:@"%ld米",poi.distance];
        cell.address_label.text = poi.address;
        
        cell.busenise_label.text = poi.businessArea;
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    [UIView animateWithDuration:1.0 delay:0.05*indexPath.section usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     AMapPOI *poi = self.datasource[indexPath.row];
    LocationMap_Vc *vc = [[LocationMap_Vc alloc]init];
    vc.hidesBottomBarWhenPushed = YES;

    vc.longtitude = poi.location.longitude;
    vc.latitude = poi.location.latitude;
    vc.name_title = poi.name;
    vc.distance = [NSString stringWithFormat:@"距离%ld米",poi.distance];

    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
