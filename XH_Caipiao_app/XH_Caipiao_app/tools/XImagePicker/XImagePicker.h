//
//  ImagePicker.h
//  BDKit
//
//  Created by 信昊 on 16/1/20.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XImagePickerFinishAction)(UIImage *image);

@interface XImagePicker : NSObject

/**
 @param viewController  用于present UIImagePickerController对象
 @param allowsEditing   是否允许用户编辑图像
 */
+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(XImagePickerFinishAction)finishAction;

@end
