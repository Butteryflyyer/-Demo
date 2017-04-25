//
//  Single.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
//单利
final class Single: NSObject {
   static let shared = Single()
    private override init() {
        
    }
}

final class Single2: NSObject{
    static var shared: Single2{
        struct Static{
            static let instance: Single2 = Single2()
        }
        return Static.instance
    }
   private  override init() {
    
    }
}
