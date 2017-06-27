//
//  QDWTools+AlertController.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/12/9.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWTools+AlertController.h"

@implementation QDWTools (AlertController)
/**
 *  提示 alertviewcontroller
 *
 *  @param title  <#title description#>
 *  @param detial <#detial description#>
 *  @param view   <#view description#>
 */

+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view{
    
    
    UIAlertAction *BackHomePage = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:BackHomePage];
    
    
    [view presentViewController:alertController animated:YES completion:nil];
    
    
    
}
/**
 *  提示alertviewcontroller 点击我知道了 返回前一页
 *
 *  @param title  <#title description#>
 *  @param detial <#detial description#>
 *  @param view   <#view description#>
 */
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view{
    
    
    UIAlertAction *BackHomePage = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [view.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:BackHomePage];
    
    
    [view presentViewController:alertController animated:YES completion:nil];
    
    
    
}
/**
 *  点击我知道了，进行相应的操作
 *
 *  @param title     <#title description#>
 *  @param detial    <#detial description#>
 *  @param view      <#view description#>
 *  @param KnowBlcok <#KnowBlcok description#>
 */
+(void)ShowTishiAlertControllerIKnowCanDoSomeThingWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithBlock:(void(^)(id data))KnowBlcok{
    
    
    UIAlertAction *BackHomePage = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        KnowBlcok(@"Back");
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:BackHomePage];
    
    
    [view presentViewController:alertController animated:YES completion:nil];
    
    
    
}
//  对于alerviewcontroller的封装。  block

+(void)ShowTishiAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock{
    
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:Canceltitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlock(@"cancel");
        
        
    }];
    
    UIAlertAction *MakeSure = [UIAlertAction actionWithTitle:MakeSureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MakeSureBlock(@"makesure");
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:Cancel];
    [alertController addAction:MakeSure];
    
    [view presentViewController:alertController animated:YES completion:nil];
    
   
    
    
}

//  对于版本升级alerviewcontroller的封装。  block

+(void)ShowVersionHelpAlertControllerWithTitle:(NSString *)title AndDetial:(NSString *)detial WithView:(UIViewController *)view WithCancelTitle:(NSString *)Canceltitle WithMakeSureTitle:(NSString *)MakeSureTitle Withstyle:(NSTextAlignment)style  CancelActionBlock:(void(^)(id data))CancelBlock MakSureActionBlock:(void(^)(id data))MakeSureBlock{
    
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:Canceltitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlock(@"cancel");
        
        
    }];
    
    UIAlertAction *MakeSure = [UIAlertAction actionWithTitle:MakeSureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MakeSureBlock(@"makesure");
        
    }];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:detial preferredStyle:UIAlertControllerStyleAlert];
    
    [QDWTools ChangeAlertControllerSubLabelWithStyle:style WithAlerController:alertController WithMessage:detial];
    
    [alertController addAction:Cancel];
    [alertController addAction:MakeSure];
    
    [view presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}


/**
  遍历alertviewcontroller的subview。并且改变里面label的对齐方式

 @param style <#style description#>
 @param Alert <#Alert description#>
 */
+(void)ChangeAlertControllerSubLabelWithStyle:(NSTextAlignment)style WithAlerController:(UIAlertController *)Alert WithMessage:(NSString *)MessageText{
    
    
    
    UIView *subView1 = Alert.view.subviews[0];

    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    
//    UILabel *title = subView5.subviews[0];
    UILabel *message = subView5.subviews[1];
    

    message.textAlignment = style;
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:MessageText];
//    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:_COLOR_RGB(0xe72a2d) range:NSMakeRange(0, MessageText.length)];
//   
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:FontSystem(14) range:NSMakeRange(0, MessageText.length)];
    
    [Alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];

    
}



@end
