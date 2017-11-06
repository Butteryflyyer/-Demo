//
//  info_cell.h
//  snake_xinhao
//
//  Created by 信昊 on 2017/10/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface info_cell : UITableViewCell
@property(nonatomic,strong)NSIndexPath *indexpath;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@end
