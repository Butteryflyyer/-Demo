//
//  CityViewController.m
//  JiuYouApp
//
//  Created by 信昊 on 15/11/24.
//  Copyright © 2015年 XH.draway.com. All rights reserved.
//

#import "CityViewController.h"

#import "CityCustomcell.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,CityCustomcelldelegate>



@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self getCityData];
    [self CreatUI];
    
    self.title = @"城市";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)initData{
 
    
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        
        
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}
-(void)CreatUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}
#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self._arr = [NSMutableArray arrayWithArray:self.keys];
    
    
    [self._arr insertObject:@"#" atIndex:0];
    
    
    //添加热门城市
    
    //    [self.cities setObject:_arrayHotCity forKey:strHot];
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 43;
    }else{
        return 30.0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (SCREEN_WIDTH > 320) {
            
            if ([self.IfSearchOrRegist isEqual:@"搜索"]) {
                return 330;
            }
            if (self.IfSearchOrRegist == nil) {
                return 300;
            }
            
        }
        if ([self.IfSearchOrRegist isEqual:@"搜索"]) {
            return 260;
        }
        if (self.IfSearchOrRegist== nil) {
            return 230;
        }
    }
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    
    if (section==0) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
        bgView.backgroundColor = _COLOR_RGB(0xF5F5F5);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(QDWRealValue(10), 11.5, 250, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = _COLOR_RGB(0x4c4c4c);
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.text = @"热门城市";
        
        [bgView addSubview:titleLabel];
        
        bgView.backgroundColor = _COLOR_RGB(0xffffff);
        
        return bgView;
        
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        bgView.backgroundColor = _COLOR_RGB(0xF5F5F5);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 5, 250, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = _COLOR_RGB(0x4c4c4c);
        titleLabel.font = [UIFont systemFontOfSize:13];
        NSString *key = [_keys objectAtIndex:section-1];
        titleLabel.text = key;
        
        [bgView addSubview:titleLabel];
        
        return bgView;
        
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    
    return self._arr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        NSString *key = [_keys objectAtIndex:section-1];
        NSArray *citySection = [_cities objectForKey:key];
        return [citySection count];
        
    }
    
    // Return the number of rows in the section.
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        
        
        CityCustomcell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCustomcell"];
        
        
        if (!cell) {
            cell = [[CityCustomcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CityCustomcell" With:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithifSearchOrSelected:self.IfSearchOrRegist];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor clearColor];
            
        }
        cell.delegate = self;
        
        [cell createViews];
        
        return cell;
        
        
        
        
        
    }else{
        
        static NSString *CellIdentifier = @"Cell";
        
        NSString *key = [_keys objectAtIndex:indexPath.section-1];
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.textLabel setTextColor:_COLOR_RGB(0x666666)];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        
        
        cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
        return cell;
        
        
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section != 0) {
        
        UITableViewCell *cell =  [_tableView cellForRowAtIndexPath:indexPath];
        
        //发送信号
        
        if (self.delegateSignal) {
            
            [self.delegateSignal sendNext:cell.textLabel.text];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
        NSLog(@"%@",cell.textLabel.text) ;

        
        
    }    
    
}
-(void)Transationwords:(NSString *)word{
    
    
    if (self.delegateSignal) {
        
        [self.delegateSignal sendNext:word];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
    
    
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
