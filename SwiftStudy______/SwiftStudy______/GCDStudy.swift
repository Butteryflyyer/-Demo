//
//  GCDStudy.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import Foundation

class GCDStudy {
//    before<NSThread: 0x7fcfc9f000d0>{number = 1, name = main}
//    after<NSThread: 0x7fcfc9f000d0>{number = 1, name = main}
//    task<NSThread: 0x7fcfc9d2d670>{number = 3, name = (null)}
    func Global_Asy(){
          print("task" + "\(Thread.current)")
        DispatchQueue.global().async {
             print("task" + "\(Thread.current)")
        }
            print("task" + "\(Thread.current)")
    }

    func Global_Sy(){
        DispatchQueue.global().sync {
            
        }
        
    }
    //线程池会出现服用
    func Global_for(){
        let global = DispatchQueue.global()
        for _ in 0..<10{
            global.async {
                
            }
        }
    }
    
    func Global_Asy_Getmain(){
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                
            }
        }
    }
    
}
