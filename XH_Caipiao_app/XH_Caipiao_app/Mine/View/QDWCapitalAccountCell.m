//
//  QDWCapitalAccountCell.m
//  QianDaoWeiApp
//
//  Created by 融联 on 16/4/26.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWCapitalAccountCell.h"

@implementation QDWCapitalAccountCell

// 添加所有子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat margin1 = 10;
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.font = FontSystem(QDWRealValue(16));
        titleLabel.textColor = _COLOR_RGB(0x333333);
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(margin1);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@QDWRealValue(20));
            
        }];
        
        // accessory
        UIImageView *rightArrowImage = [[UIImageView alloc] init];
        rightArrowImage.image = [UIImage imageNamed:@"个人中心右"];
        [self.contentView addSubview:rightArrowImage];
        
   
        [rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(QDWRealValue(-12));
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@QDWRealValue(10));
            make.height.equalTo(@QDWRealValue(10));
        }];
        
  
    }
    
    return self;
}

@end
