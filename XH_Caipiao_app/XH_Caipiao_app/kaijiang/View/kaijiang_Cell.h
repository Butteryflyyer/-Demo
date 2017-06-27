//
//  kaijiang_Cell.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kaijiang_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;
@property(nonatomic,strong)Caipiao_Model *model;

@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *qishu_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@end
