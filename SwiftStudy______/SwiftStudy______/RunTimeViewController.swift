//
//  RunTimeViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class RunTimeViewController: BaseViewController {

    var name :String = "xinhao"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        
        getMethodAndPropertiesFromClass(cls: self.classForCoder)
        getMethodAndPropertiesFromClass(cls: TestSwiftRuntimeClass.self)
        swizzleMethod(cls: self.classForCoder, orginMethod: #selector(RunTimeViewController.getMyname(name:)), destinationMethod:  #selector(RunTimeViewController.returnTuple(name:)))
        
        print( getMyname(name: "11"))
       print(returnTuple(name: "11"))
        
        
        // Do any additional setup after loading the view.
    }
    dynamic func getMyname(name: String) -> Int{
        print("getMyname_____________________________")
        return 12
    }
    
   dynamic func returnTuple(name: String) -> Int{
    print("returntuple_______________________________")
        return 10
    }
    
    
    func swizzleMethod(cls: AnyClass!,orginMethod:Selector, destinationMethod:Selector){
        let orgin = class_getInstanceMethod(cls, orginMethod)
        let swiz = class_getInstanceMethod(cls, destinationMethod)
        method_exchangeImplementations(orgin, swiz)
    }
    
    func getMethodAndPropertiesFromClass(cls: AnyClass){
        
      print("-----------------------------")
        var methodNum: UInt32 = 0
        let methods = class_copyMethodList(cls, &methodNum)
        for index in 0..<numericCast(methodNum){
            let met : Method = methods![index]!
            print("m_name:\(method_getName(met))")
            print("m_retutype:\( String(utf8String: method_copyReturnType(met)))")
            print("m_type: \(String(utf8String: method_getTypeEncoding(met)))")
           
        }
        
        print("-----------------------------")
        
        var proNum :UInt32 = 0
        let properties = class_copyPropertyList(cls, &proNum)
        for index in 0..<numericCast(proNum){
            let pro: objc_property_t = properties![index]!
            
            print("p_name: \(String(utf8String: property_getName(pro)))")
            
            print("p_attr: \(String(utf8String: property_getAttributes(pro)))")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
