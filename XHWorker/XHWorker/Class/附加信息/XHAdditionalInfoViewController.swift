//
//  XHAdditionalInfoViewController.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHAdditionalInfoViewController: XHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpUI()
        titleLabel.transform = CGAffineTransform.init(translationX: 0, y: -200)
        
        additionTextView.transform = CGAffineTransform.init(translationX: 0, y: 800)
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: { 
            
            self.titleLabel.transform = CGAffineTransform.identity
            
            self.additionTextView.transform = CGAffineTransform.identity
            
            }) { (_) in
                
                //
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.additionTextView.transform = CGAffineTransform.identity
                    }, completion: nil)
                
                
                
        }
        
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK:- 内部控制方法
    private func setUpUI() {
        view.addSubview(titleLabel)
        view.addSubview(additionTextView)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.width.equalTo(view)
            make.height.equalTo(30)
            make.top.equalTo(view).offset(25)
        }
        additionTextView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.bounds.width * 0.8)
            make.height.equalTo(self.view.bounds.height * 0.5)
            make.center.equalTo(self.view.center)
        }
    }
    
    // MARK:- lazy
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.red
        lb.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0)
        lb.text = "附加信息"
        lb.font = UIFont.systemFont(ofSize: 32)
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    private var additionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.tintColor = UIColor.white
        tv.textColor = UIColor.white
        tv.font = UIFont.systemFont(ofSize: 27)
        tv.text = "                                                                                            这里我想强调下，我要找一份iOS开发的工作，其他的勿扰！谢谢！                                                 目前处于在职状态，这样可以疏通知识并且方便以后忘记了回来查看或者复习，你们可以通过我的博客了解我的专业知识,这些知识基本都是通过自学获得。                                                                                                                                                                                        在软件行业，自学是必不可少的能力。你永远无法熟悉一个领域的所有知识，但是你必须能够通过网络迅速去掌握项目所需的技术。"
        tv.sizeToFit()
        return tv
    }()


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
