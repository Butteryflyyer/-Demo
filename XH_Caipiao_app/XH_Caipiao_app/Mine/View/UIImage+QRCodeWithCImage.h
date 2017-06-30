//
//  UIImage+QRCodeWithCImage.h
//  07-生成二维码
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCodeWithCImage)

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

@end
