//
//  PersonalEditVM.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalEditVM : NSObject

-(instancetype)initWithTable:(UITableView *)table;

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIViewController *myController;

@property(nonatomic,strong)QDWUserPersonalInfo *userInfo;

@end
