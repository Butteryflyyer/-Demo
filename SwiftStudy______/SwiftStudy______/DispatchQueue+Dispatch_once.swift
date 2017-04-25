//
//  DispatchQueue+Dispatch_once.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
//dispatch_once 拓展
public extension DispatchQueue{
     private static var _onceTracker = [String]()
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
