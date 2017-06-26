//
//  Login_normal_Cell.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/6/15.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login_normal_Cell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *Login_Index_Path;//登陆的时候

@property(nonatomic,strong)NSIndexPath *Regist_Index_Path;//注册时候

@property (weak, nonatomic) IBOutlet UITextField *title_Detail_textfield;
@end
