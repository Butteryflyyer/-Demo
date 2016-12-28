//
//  XHBaseInfoViewController.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHBaseInfoViewController: XHBaseViewController {

    
    var viewWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewWidth = self.view.bounds.width
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setUpLabels()
        setUpTranform()
        
        
        // Do any additional setup after loading the view.
    }

    func setUpLabels(){
        
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(ageLabel)
        view.addSubview(marryLabel)
        view.addSubview(exprLabel)
        view.addSubview(attLabel)
        
        
        titleLabel.frame = CGRect(x: 0, y: 20, width:viewWidth , height: 50)
        nameLabel.frame = CGRect(x: 0, y: 150, width: viewWidth, height: 50)
        
        ageLabel.frame = CGRect(x: 0, y: 200, width: viewWidth, height: 50)
        
        marryLabel.frame = CGRect(x: 0, y: 250, width: viewWidth, height: 50)
        
        exprLabel.frame = CGRect(x: 0, y: 300, width: viewWidth, height: 50)
        
        attLabel.frame = CGRect(x: 0, y: 400, width: viewWidth, height: 50)
        
        
        
        
    }
    
    func setUpTranform(){
        
        titleLabel.transform = CGAffineTransform.init(translationX: 0, y: -100)
        titleLabel.alpha = 0
        
        nameLabel.transform = CGAffineTransform.init(translationX: viewWidth, y: 0)
        
        ageLabel.transform = CGAffineTransform.init(translationX: -viewWidth, y: 0)
        
        marryLabel.transform = CGAffineTransform.init(translationX: viewWidth, y: 0)
        
         exprLabel.transform = CGAffineTransform.init(translationX: -viewWidth, y: 0)
        
        attLabel.transform = CGAffineTransform.init(translationX: viewWidth, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: { 
            
             self.titleLabel.transform = CGAffineTransform.identity
             self.titleLabel.alpha = 1
            
            
            }) { (_) in
                
                  self.nameLabel.transform = CGAffineTransform.identity
                  self.exprLabel.transform = CGAffineTransform.identity
                  self.ageLabel.transform = CGAffineTransform.identity
                  self.marryLabel.transform = CGAffineTransform.identity
                  self.attLabel.transform = CGAffineTransform.identity
          
              
                
        }
        
        
        
        
        
    }
    
    
    
    
    
    fileprivate var titleLabel: UILabel = {
        
       var label = UILabel()
       label.font = UIFont.systemFont(ofSize: 32)
       label.textColor = UIColor.red
       label.numberOfLines = 0 as Int
       
       label.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0)
       label.text = "基本资料"
       label.textAlignment = NSTextAlignment.center
        
        return label
        
    }()
    
    fileprivate var nameLabel: UILabel = {
       
        var label = UILabel()
        label.text = "姓名: 保密"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        
        return label
        
        
    }()
    
    fileprivate var ageLabel: UILabel = {
        
       
        var label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "年龄：23"
        label.numberOfLines = 0 as Int
        
        return label
        
    }()
    fileprivate var marryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "婚否：未婚"
        lb.numberOfLines = 0 as Int
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    fileprivate var exprLabel: UILabel = {
        let lb = UILabel()
        lb.text = "工作经验：2年"
        lb.numberOfLines = 0 as Int
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    fileprivate var attLabel: UILabel = {
        let lb = UILabel()
        lb.text = "求职：目前离职，希望找一份iOS相关的工作"
        lb.numberOfLines = 0 as Int
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()

    
    
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
