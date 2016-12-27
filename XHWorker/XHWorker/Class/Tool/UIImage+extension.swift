//
//  UIImage+extension.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

extension UIImage{
    
    func scaleImage(width: CGFloat) -> UIImage {
        
        if size.width < width {
            return self
        }
        
        let height = width * size.height / size.width
        let newsize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContext(newsize)
        UIGraphicsGetCurrentContext()
        
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        
        
        UIGraphicsEndImageContext()
        
        
        return newImage
        
    }
    
    
    
    
}
