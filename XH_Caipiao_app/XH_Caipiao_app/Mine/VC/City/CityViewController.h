//
//  CityViewController.h
//  JiuYouApp
//
//  Created by 信昊 on 15/11/24.
//  Copyright © 2015年 XH.draway.com. All rights reserved.
//

#import "BaseViewController.h"


//@protocol CityViewControllerDelegate <NSObject>
//
//-(void)transCity:(NSString *)str;
//
//@end

@interface CityViewController : BaseViewController


@property(nonatomic, copy)NSString *IfSearchOrRegist;//是注册还是选择城市

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母

@property(nonatomic,retain)NSMutableArray *_arr;
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;



@property(nonatomic,strong)UITableView *tableView;

/**
 *  替代代理
 */
@property(nonatomic,strong)RACSubject *delegateSignal;


//@property(nonatomic,weak)id <CityViewControllerDelegate>delegate;

@end
