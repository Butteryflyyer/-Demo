//
//  PersonalIcon_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/28.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "PersonalIcon_Cell.h"

@interface PersonalIcon_Cell ()


@end

@implementation PersonalIcon_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

-(void)setIndexPath:(NSIndexPath *)IndexPath{
    _IndexPath = IndexPath;
   
    if (self.PersonalInfoImg) {
        self.PersonIconImg.image = self.PersonalInfoImg;
    }else{
        [self.PersonIconImg sd_setImageWithURL:[NSURL URLWithString:self.userInfo.userInfo.avatarpath] placeholderImage:[UIImage imageNamed:@"个人中心头像默认"]]; 
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
