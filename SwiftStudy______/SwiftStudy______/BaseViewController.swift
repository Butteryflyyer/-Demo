//
//  BaseViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        SetBackGroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        var btn = UIButton.init(type: .contactAdd)
        
        btn.frame = CGRect(x: 10, y: 10, width: 40, height: 20)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        btn.addTarget(self, action: #selector(BaseViewController.BackClick), for: .touchDragInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func BackClick(){
        self.dismiss(animated: true, completion: nil)
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
extension BaseViewController{
    
    func SetBackGroundColor(){
        
        
        self.view.backgroundColor = UIColor.white
        
    }
 
    
}
