//
//  ZoushiDetail_Vc.h
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "BaseViewController.h"
@protocol XWPageCoverPushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end
@interface ZoushiDetail_Vc : BaseViewController<UINavigationControllerDelegate>


@property(nonatomic,copy)NSString *title_text;

@property(nonatomic,copy)NSString *style_url;

@property (nonatomic, assign) id<XWPageCoverPushControllerDelegate> delegate;

@end
