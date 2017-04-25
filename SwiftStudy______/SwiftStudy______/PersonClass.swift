//
//  PersonClass.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/17.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

protocol myNameed {
    var fullName: String{ set get}
    
    func getName() -> String
    
    mutating func changeStruct()
    
    func `init`(name: String)
}

struct Person: myNameed {
    internal func `init`(name: String) {
        
    }

    mutating internal func changeStruct() {
        
    }

    internal func getName() -> String {
        return "hao"
    }
   
    
    internal var fullName: String

    
}




 class PersonClass: NSObject,myNameed {
    internal func `init`(name: String) {
        
    }

   internal func changeStruct() {
        
    }

    internal func getName() -> String {
        return "hao"
    }

    internal var fullName: String = ""

    override init() {
        var name = Person.init(fullName: "").getName()
    }

}
