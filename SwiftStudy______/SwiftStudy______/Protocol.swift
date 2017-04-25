

//
//  Protocol.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/17.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
protocol Text1{
    var name : String{get}
}
protocol Text2 {
    var age : Int{
        get
    }
    
}
struct PersonName: Text1,Text2 {
    internal var age: Int
    
    internal var name: String
    
}


class Protocol: NSObject {
    typealias  block=(Int)-> Void
    
    var myblcok: block?
    
    func my(bl: block){
     
        myblcok!(1)
    }
    
 
    
    func wish(to cele: Text1 & Text2){
        print("11")
    }
    func getresult(){
        let personinstance = PersonName.init(age: 1, name: "hao")
         wish(to: personinstance)
        
       print(unsafeBitCast(personinstance, to: PersonName.self))
    }
    
}


