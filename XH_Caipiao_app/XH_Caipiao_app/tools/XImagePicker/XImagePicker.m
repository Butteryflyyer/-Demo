//
//  ImagePicker.m
//  BDKit
//
//  Created by 信昊 on 16/1/20.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XImagePicker.h"

@interface XImagePicker()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) XImagePickerFinishAction finishAction;
@property (nonatomic, assign) BOOL allowsEditing;
@property (nonatomic, assign) BOOL CameraOrLibrary;//拍照还是相册 拍照把选中的照片存入相册中

@end


static XImagePicker *XImagePickerInstance = nil;

@implementation XImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAction:(XImagePickerFinishAction)finishAction {
    if (XImagePickerInstance == nil) {
        XImagePickerInstance = [[XImagePicker alloc] init];
    }
    
    [XImagePickerInstance showImagePickerFromViewController:viewController
                                               allowsEditing:allowsEditing
                                                finishAction:finishAction];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(XImagePickerFinishAction)finishAction {
    _viewController = viewController;
    _finishAction = finishAction;
    _allowsEditing = allowsEditing;
    
    UIActionSheet *sheet = nil;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从相册选择", nil];
    }
    
    UIView *window = [UIApplication sharedApplication].keyWindow;
    [sheet showInView:window];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"拍照"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
        _CameraOrLibrary = YES;
        [_viewController presentViewController:picker animated:YES completion:nil];
        
    }else if ([title isEqualToString:@"从相册选择"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        _CameraOrLibrary = NO;
        [_viewController presentViewController:picker animated:YES completion:nil];
    }else {
        XImagePickerInstance = nil;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    if (_finishAction) {
        _finishAction(image);
    }
    if (_CameraOrLibrary == YES) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    XImagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_finishAction) {
        _finishAction(nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    XImagePickerInstance = nil;
    
}

@end
