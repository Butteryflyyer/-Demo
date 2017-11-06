//
//  XBGUserLoginRegistHelper.m
//  xiaoxinyong
//
//  Created by 信昊 on 2017/9/13.
//  Copyright © 2017年 xiaoxinyong. All rights reserved.
//

#import "XBGUserLoginRegistHelper.h"
#import "Tools.h"
@implementation XBGUserLoginRegistHelper

//+(BOOL)Login_YanzhengWithphone:(NSString *)phone Withpassword:(NSString *)password{
//    if (phone.length >0) {
//        if ([Tools checkTelNumber:phone]) {
//            if (password.length > 0) {
//                if ([Tools checkPassword:password]) {
//                    return YES;
//                }else{
//                  [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入8-16位密码"];
//                }
//            }else{
//               [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入密码"];
//            }
//        }else{
//           [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入正确手机号"];
//        }
//    }else{
////        [[Tools getCurrentVC]showHint:@"请输入手机号"];
//        [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入手机号"];
//    }
//    return NO;
//}
//
//+(BOOL)YanzhengWithphone:(NSString *)phone{
//    if (phone.length > 0) {
//        if ([Tools checkTelNumber:phone]) {
//            return YES;
//        }else{
//           [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入正确手机号"];
//        }
//    }else{
//      [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入手机号"];
//    }
//    return NO;
//}
//
//+(BOOL)Regist_YanzhengWithphone:(NSString *)phone Withyanzhen:(NSString *)yanzhennum Withpassword:(NSString *)password WithinvitePerson:(NSString *)invitePhone WithIfhave_invitePerson:(BOOL)invite_show{
//    if (phone.length >0) {
//        if ([Tools checkTelNumber:phone]) {
//            if (yanzhennum.length == 6) {
//                if (password.length > 0) {
//                    if ([Tools checkPassword:password]) {
//                        if (invite_show == NO) { //如果没有邀请人这一栏
//                            return YES;
//                        }else{//如果有邀请人这一栏
//                            if (invitePhone.length > 0) {
//                                if ([Tools checkTelNumber:invitePhone]) {
//                                    return YES;
//                                }else{
//                                  [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入正确邀请人手机号"];
//                                }
//                            }else{
//                               [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入邀请人手机号"];
//                            }
//                        }
//                    }else{
//                        [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入8-16位密码"];
//                    }
//                }else{
//                    [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入密码"];
//                }
//            }else{
//                [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入6位验证码"];
//            }
//           }else{
//            [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入正确手机号"];
//        }
//    }else{
//        //        [[Tools getCurrentVC]showHint:@"请输入手机号"];
//        [[Tools getCurrentVC]showHintBeforeKeyboard:@"请输入手机号"];
//    }
//    return NO;
//}

@end
