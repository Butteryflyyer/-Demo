//
//  EditSelected_Cell.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSelected_Cell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *IndexPath;

@property(nonatomic,strong)QDWUserPersonalInfo *userInfo;

@property (weak, nonatomic) IBOutlet UITextField *myTextfield;
@end
