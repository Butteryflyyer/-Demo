//
//  XHMainScrollView.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHMainScrollView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
            
            let pan:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            if pan.translation(in: self).x > 0.0 && self.contentOffset.x == 0.0 {
                
                return false
                
                
                
            }
            
            
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let offset = point.x
        if offset < 70 {
            
            
            return nil
        }
        
        
        return super.hitTest(point, with: event)
    }
    
    
    

}
