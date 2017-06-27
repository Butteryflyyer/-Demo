//
//  PersonalEditVM.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "PersonalEditVM.h"
#import "PersonalIcon_Cell.h"
#import "EditInfo_Cell.h"
#import "EditSelected_Cell.h"
#import "EditRightEmpty_Cell.h"
#import "SinglePickView.h"
#import "CityViewController.h"
#import "XImagePicker.h"
static NSString *const PersonalIcon_cell = @"PersonalIcon_Cell";
static NSString *const EditInfo_cell = @"EditInfo_Cell";
static NSString *const EditSelected_cell = @"EditSelected_Cell";
static NSString *const EditRightEmpty_cell = @"EditRightEmpty_Cell";


@interface PersonalEditVM ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)SinglePickView *SexPickView;
@property(nonatomic,strong)UIImage *PersonalInfoImage;// 存储取出来的头像来刷新

@end

@implementation PersonalEditVM

-(instancetype)initWithTable:(UITableView *)table{
    if (self = [super init]) {
        self.myTableView = table;
        self.myTableView.delegate= self;
        self.myTableView.dataSource = self;
        void(^RegistBlock)(NSString *) = ^(NSString *identity){
            [self.myTableView registerNib:[UINib nibWithNibName:identity bundle:nil] forCellReuseIdentifier:identity];
        };
        RegistBlock(PersonalIcon_cell);
        RegistBlock(EditInfo_cell);
        RegistBlock(EditSelected_cell);
        RegistBlock(EditRightEmpty_cell);
   
    }
    return self;
}

-(void)setUserInfo:(QDWUserPersonalInfo *)userInfo{
    _userInfo = userInfo;
    [self.myTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 5;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonalIcon_Cell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalIcon_cell];
            cell.PersonalInfoImg = self.PersonalInfoImage;
            cell.userInfo = self.userInfo;
            cell.IndexPath = indexPath;
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0||indexPath.row == 2 || indexPath.row == 3) {
            EditInfo_Cell *cell = [tableView dequeueReusableCellWithIdentifier:EditInfo_cell];
            cell.userInfo = self.userInfo;
            cell.IndexPath = indexPath;  
            [[cell.DetailTextField.rac_textSignal skip:1] subscribeNext:^(id x) {
                if (indexPath.row == 0) {
                    self.userInfo.userInfo.name = x;
                }
                if (indexPath.row == 2) {
                    self.userInfo.userInfo.phone = x;
                }
                if (indexPath.row == 3) {
                    self.userInfo.userInfo.cardnum = x;
                }
            }];
            return cell;
        }
        if (indexPath.row == 1) {
            EditSelected_Cell *cell = [tableView dequeueReusableCellWithIdentifier:EditSelected_cell];
            cell.IndexPath = indexPath;
            return cell;
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            EditSelected_Cell *cell = [tableView dequeueReusableCellWithIdentifier:EditSelected_cell];
            cell.userInfo = self.userInfo;
            cell.IndexPath = indexPath;
            return cell;
        }
        if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
            EditInfo_Cell *cell = [tableView dequeueReusableCellWithIdentifier:EditInfo_cell];
            cell.userInfo = self.userInfo;
            cell.IndexPath = indexPath;
            [[cell.DetailTextField.rac_textSignal skip:1] subscribeNext:^(id x) {
                if (indexPath.row == 1) {
                    self.userInfo.userInfo.workunit = x;
                }
                if (indexPath.row == 3) {
                    self.userInfo.userInfo.position = x;
                }
                if (indexPath.row == 4) {
                    self.userInfo.userInfo.email = x;
                }
            }];
            return cell;
        }
        if (indexPath.row == 2) {
            EditRightEmpty_Cell *cell = [tableView dequeueReusableCellWithIdentifier:EditRightEmpty_cell];
            cell.userInfo = self.userInfo;
            cell.IndexPath = indexPath;
            [[cell.myTextfield.rac_textSignal skip:1] subscribeNext:^(id x) {
                self.userInfo.userInfo.workexperience = x;
            }];
            return cell;
        }
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 95;
    }else{
        return 45;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        backView.backgroundColor = _COLOR_RGB(0xf5f5f5);
        return backView;
    }
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 0) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        backView.backgroundColor = _COLOR_RGB(0xf5f5f5);
        return backView;
    }
    if (section == 2) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        backView.backgroundColor = _COLOR_RGB(0xf5f5f5);
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:_COLOR_RGB(0xffffff) forState:UIControlStateNormal];
        [saveBtn setBackgroundImage:[UIImage imageNamed:FormatMidCicle_btn_ImageName] forState:UIControlStateNormal];
        saveBtn.titleLabel.font = FontSystem(17);
        saveBtn.frame = CGRectMake((SCREEN_WIDTH-245)/2, 20, 245, 40);
        saveBtn.layer.cornerRadius = 10;
        [[saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [self SavePersonalInfo];
        }];
        [backView addSubview:saveBtn];
        return backView;
    }
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 10;
    }
    if (section == 2) {
        return 80;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self getPersonalInfoImage];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self SelectSex];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            CityViewController *CityVc = [[CityViewController alloc]init];
 
            CityVc.delegateSignal = [RACSubject subject];
            
            [CityVc.delegateSignal subscribeNext:^(id x) {
                
                NSString *text = (NSString *)x;
                
                self.userInfo.userInfo.workcity = text;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.myTableView reloadData];
                });
               
            }];
 
            [self.myController.navigationController pushViewController:CityVc animated:YES];
        }
    }
}
#pragma mark --选择性别
-(void)SelectSex{
    
    NSArray *SexSource = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
    
    self.SexPickView = [[SinglePickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) WithOneArr:SexSource];
    
    [self.myController.view addSubview:self.SexPickView];
    
    @weakify(self);
    [[self.SexPickView.SuccessButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        NSString *AppendStr;
        
        AppendStr = self.SexPickView.OneComponentStr;
        if ([AppendStr isEqual:@"男"]) {
           self.userInfo.userInfo.sex = @"0";
        }else {
            self.userInfo.userInfo.sex = @"1";
        }
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.myTableView reloadData];
       });
        [self.SexPickView removeFromSuperview];
    }];
    
}
#pragma mark -- 获取头像
-(void)getPersonalInfoImage{
    @weakify(self)
    [XImagePicker showImagePickerFromViewController:self.myController allowsEditing:YES finishAction:^(UIImage *image) {
        @strongify(self)
        if (image) {
            self.PersonalInfoImage = image;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }];

}
#pragma mark -- 保存
-(void)SavePersonalInfo{
    NSData *imageData = UIImageJPEGRepresentation(self.PersonalInfoImage, 1);
    NSString *updataimageStr =[Base64codeFunc base64EncodedStringFrom:imageData];
    NSDictionary *dict;
    if (self.PersonalInfoImage) {
        dict = @{
                 @"userId":[QDWUser shareManager].Userid,
                 @"avatorpath":updataimageStr,
                 @"sex":self.userInfo.userInfo.sex,
                 @"email":self.userInfo.userInfo.email,
                 @"position":self.userInfo.userInfo.position,
                 @"name":self.userInfo.userInfo.name,
                 @"cardnum":self.userInfo.userInfo.cardnum,
                 @"workcity":self.userInfo.userInfo.workcity,
                 @"workunit":self.userInfo.userInfo.workunit,
                 @"workexperience":self.userInfo.userInfo.workexperience,
                 @"phone":self.userInfo.userInfo.phone
                 };
 
    }else{
        dict = @{
                 @"userId":[QDWUser shareManager].Userid,
                 @"sex":self.userInfo.userInfo.sex,
                 @"email":self.userInfo.userInfo.email,
                 @"position":self.userInfo.userInfo.position,
                 @"name":self.userInfo.userInfo.name,
                 @"cardnum":self.userInfo.userInfo.cardnum,
                 @"workcity":self.userInfo.userInfo.workcity,
                 @"workunit":self.userInfo.userInfo.workunit,
                 @"workexperience":self.userInfo.userInfo.workexperience,
                 @"phone":self.userInfo.userInfo.phone
                 };

    }
  
    [SVProgressHUD showWithStatus:@"保存中"];
    @weakify(self)
    [MinePageManager EditInfoWithUrl:QDWEditInfo_URL WithDict:dict SuccessBlock:^(id data) {
        [SVProgressHUD dismiss];
      @strongify(self)
        if (data) {
            [self.myController.navigationController popViewControllerAnimated:YES];
        }
     } FailureBlock:^(id data) {

        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }];

}
#pragma mark -- 分割线左右顶头
-(void)viewDidLayoutSubviews
{
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0,15,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,15,0,0)];
    }
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,15,0,0)];
    }
}

@end
