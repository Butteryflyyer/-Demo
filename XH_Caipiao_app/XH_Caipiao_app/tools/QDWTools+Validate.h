//
//  QDWTools+Validate.h
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/12/9.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "QDWTools.h"

@interface QDWTools (Validate)
/**
 *  手机号验证
 *
 *  @param mobile <#mobile description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)validateMobile:(NSString *)mobile;


/**
 *  电话号验证
 *
 *  @param mobile <#mobile description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)validateHomeMobile:(NSString *)mobile;
/**
 *  密码验证
 *
 *  @param password
 *
 *  @return
 */
+(BOOL)validatePassword:(NSString *)password;
/**
 *  身份证号验证
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;


@end
