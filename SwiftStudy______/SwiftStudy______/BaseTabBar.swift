//
//  BaseTabBar.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.addController()
        
        // Do any additional setup after loading the view.
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
extension BaseTabBar{
    
    func addController() -> Void {
        
        self.add(Vc: FirstViewController(), ImageName: "钱小秘", SelectName: "钱小秘", Name: "前小米")
        self.add(Vc: SecondViewController(), ImageName: "我的客户", SelectName: "我的客户", Name: "我的客户")
        self.add(Vc: ThirdViewController(), ImageName: "设置", SelectName: "设置", Name: "设置")
        
    }
    
    func add(Vc: UIViewController ,ImageName: String?, SelectName: String?,Name: String?) -> Void {
        
        
        let NavVc = UINavigationController.init(rootViewController: Vc)
        
        
        Vc.tabBarItem.title = Name
        
        let normalImage = UIImage.init(named: ImageName!)?.withRenderingMode(.alwaysOriginal)
         let SelectedImage = UIImage.init(named: SelectName!)?.withRenderingMode(.alwaysOriginal)
        
        Vc.tabBarItem = UITabBarItem.init(title: Name, image: normalImage, selectedImage: SelectedImage)
        
        self.addChildViewController(NavVc)
        
        
        
    }
    
    
    
}
