//
//  EditInfo_Cell.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfo_Cell : UITableViewCell

@property(nonatomic,strong)QDWUserPersonalInfo *userInfo;

@property(nonatomic,strong)NSIndexPath *IndexPath;

@property (weak, nonatomic) IBOutlet UITextField *DetailTextField;
@end
