//
//  MineNormal_Cell.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/3/27.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import "MineNormal_Cell.h"

@interface MineNormal_Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *MyTitleImg;
@property (weak, nonatomic) IBOutlet UILabel *MyTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *InvitGiftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *RightSanjiaoImage;

@end

@implementation MineNormal_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.InvitGiftLabel.hidden = YES;
    
//    // 小圆点
//    UIImageView *smallCircleView = [[UIImageView alloc] init];
//    smallCircleView.image = [UIImage imageNamed:@"圆"];
//    [self.contentView addSubview:smallCircleView];
//    self.smallCircleView = smallCircleView;
//    
//    [smallCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.RightSanjiaoImage.mas_left).offset(QDWRealValue(-5));
//        make.centerY.equalTo(self.RightSanjiaoImage.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(QDWRealValue(5), QDWRealValue(5)));
//    }];
//    smallCircleView.hidden = YES;
    // Initialization code
}

-(void)setNowRow:(NSInteger)NowRow{
    _NowRow = NowRow;
    if (NowRow == 0) {
        [self reloadCellWithImg:@"个人中心消息" WithTitle:@"消息中心"];
    }
    if (NowRow == 1) {
        [self reloadCellWithImg:@"个人中心邀请好友" WithTitle:@"邀请好友"];
        self.InvitGiftLabel.hidden = NO;
    }
    if (NowRow == 2) {
        [self reloadCellWithImg:@"个人中心商务合作" WithTitle:@"商务合作"];
    }
    if (NowRow == 3) {
        [self reloadCellWithImg:@"个人中心钱小秘" WithTitle:@"钱小秘"];
    }
    if (NowRow == 4) {
         [self reloadCellWithImg:@"个人中心设置" WithTitle:@"设置"];
    }
    
}
-(void)reloadCellWithImg:(NSString *)name WithTitle:(NSString *)title{
    self.MyTitleImg.image = [UIImage imageNamed:name];
    self.MyTitleLabel.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
