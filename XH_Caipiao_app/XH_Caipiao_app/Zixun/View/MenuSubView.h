//
//  MenuSubView.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/1/6.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSubView : UIView
@property (weak, nonatomic) IBOutlet UIButton *SelectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@property(nonatomic,strong)UIImage *NowImage;

@property(nonatomic,strong)NSString *NowText;

@end
