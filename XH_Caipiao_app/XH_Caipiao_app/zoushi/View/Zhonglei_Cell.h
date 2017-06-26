//
//  Zhonglei_Cell.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Zhonglei_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property(nonatomic,strong)Caipiao_Model *model;

@property(nonatomic,strong)NSIndexPath *indexpaht;
@end
