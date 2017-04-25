//
//  UIControl+btn.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
let defaultDuration : TimeInterval = 0.5
extension UIControl{
    
    private struct AssocitedKeys{
        static var UIControl_acceptEventInterval = "UIControl_acceptEventInterval"
        static var isIgnoreEvent = "isIgnoreEvent"
    }
   open override class func initialize(){
    
    if self !== UIButton.self {
        return
    }
    
    DispatchQueue.once(token: "OnceClick") { 
        
        let a: Method = class_getInstanceMethod(self, #selector(sendAction(_:to:for:)))
        
        let b: Method = class_getInstanceMethod(self, #selector(xh_sendAction(_:to:for:)))
        
        method_exchangeImplementations(a, b)
 
    }
  }
    func xh_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?){
        if self.xh_ignoreEvent {
            return
        }
        if self.xh_acceptEventInterval > 0{
            self.xh_ignoreEvent = true

           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+self.xh_acceptEventInterval, execute: { 
                 self.xh_ignoreEvent = false
           })
        }
        xh_sendAction(action, to: target, for: event)
    }

    var xh_acceptEventInterval: TimeInterval {
        set{
            objc_setAssociatedObject(self,&AssocitedKeys.UIControl_acceptEventInterval ,newValue as TimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let clickDuration = objc_getAssociatedObject(self, &AssocitedKeys.UIControl_acceptEventInterval) as? TimeInterval{
                return clickDuration
            }
            return defaultDuration
        }
      
    }
    var xh_ignoreEvent: Bool{
        set{
            objc_setAssociatedObject(self, &AssocitedKeys.isIgnoreEvent, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let xh_ignoreEvent = objc_getAssociatedObject(self, &AssocitedKeys.isIgnoreEvent) as? Bool{
                   return xh_ignoreEvent
            }
          return false
            
        }
    }
}
