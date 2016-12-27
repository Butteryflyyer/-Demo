//
//  XHMenuViewController.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHMenuViewController: UIViewController {

    let bgColor = UIColor(red: 00/255, green: 41/255,  blue: 82/255,   alpha: 1.0)
    
    var itemHeight:CGFloat!
    
    var menuItems:[XHMenuItem] = []
    
    let width:CGFloat = 70
    
    var showDetail:((_ v:UIView)->())?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = bgColor
        
        
        initItems()
        
        // Do any additional setup after loading the view.
    }

    func initItems(){
        
        menuItems = XHMenuItem.shareItems
        
        itemHeight = (self.view.bounds.height + (CGFloat(menuItems.count)*1))/CGFloat(menuItems.count)
        
        var itemView: XHItemView!
        
        for i in 0 ..< menuItems.count{
            
            itemView = XHItemView(frame: CGRect(x: -width - 32, y: CGFloat(i)*(itemHeight - 1), width: width * 2 + 30, height: itemHeight), title: menuItems[i].title, img: menuItems[i].symbol)
            
            view.addSubview(itemView)
            
            itemView.backgroundColor = menuItems[i].color
            
            if menuItems[i].color == self.view.backgroundColor{
                
                itemView.isSelected = true
                
                
            }
            
            itemView.showDetail = {
                v in
                
                self.showDetail?(v)
                
                
                
            }
            
            
            
        }
        
        
        
        
    }
    deinit {
        print("panduan")
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
