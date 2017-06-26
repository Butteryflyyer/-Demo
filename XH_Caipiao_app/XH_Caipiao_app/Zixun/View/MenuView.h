//
//  MenuView.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 17/1/6.
//  Copyright © 2017年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSubView.h"
@interface MenuView : UIView

@property(nonatomic,strong)MenuSubView *FindOrderView;

@property(nonatomic,strong)MenuSubView *FireOrderView;

@property(nonatomic,strong)MenuSubView *ActivityView;

@property(nonatomic,strong)MenuSubView *ServeView;

@end
