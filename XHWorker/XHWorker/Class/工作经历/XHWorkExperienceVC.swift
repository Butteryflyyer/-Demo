//
//  XHWorkExperienceVC.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHWorkExperienceVC: XHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置子控件
        setUpUI()
        
        // 设置各个控件的transform
        titleLabel.transform =  CGAffineTransform.init(translationX: 0, y: -100)
        titleLabel.alpha = 0
        
        self.view.layoutIfNeeded()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: { () -> Void in
            self.titleLabel.transform = CGAffineTransform.identity
            self.titleLabel.alpha = 1
            
        }) { (_) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                
                
            }){_ in
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    
                }){_ in
                    
                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                        
                        self.workTextView1.snp_updateConstraints({ (make) -> Void in
                            make.centerY.equalTo(self.view.center.y).offset(-20)
                        })
                        self.view.layoutIfNeeded()
                        
                    }){_ in
                        
                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 80, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                            self.workTextView2.snp_updateConstraints({ (make) -> Void in
                                make.centerY.equalTo(self.view.center.y).offset(180)
                            })
                            self.view.layoutIfNeeded()
                            
                        }){_ in
                            
                        }
                    }
                    
                }
            }
        }
    }

    
    // MARK:- 内部控制方法
    private func setUpUI() {
        view.addSubview(titleLabel)
        view.addSubview(workTextView1)
        view.addSubview(workTextView2)
        
        let width = UIScreen.main.bounds.width - 100
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.width.equalTo(view)
            make.height.equalTo(30)
            make.top.equalTo(view).offset(25)
        }
        workTextView1.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(width)
            make.height.equalTo(300)
            make.centerY.equalTo(view.center.y).offset(-800)
        }
        workTextView2.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.width.equalTo(width)
            make.height.equalTo(300)
            make.centerY.equalTo(view.center.y).offset(800)
        }
    }

    
    // MARK:- lazy
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.red
        lb.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0)
        lb.text = "工作经历"
        lb.font = UIFont.systemFont(ofSize: 32)
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
//    CGRectMake(50, 100, UIScreen.main.bounds.width, 200)
    private var workTextView1: UITextView = {
        let tv = UITextView(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width, height: 200))
        tv.backgroundColor = UIColor.clear
        tv.tintColor = UIColor.white
        tv.textColor = UIColor.white
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.text = "2015年9月 - 2016年3月                                                                       公司：深圳前海辣车科技有限                                                                            公司地点：深圳                                                                        深圳职位：iOS开发工程师                                                                             工作职责：主要负责一个叫辣车库的App。负责界面的搭建，核心代码的编写, 整体架构的搭建以及各个模块的编写"
        //        tv.sizeToFit()
        return tv
    }()
    private var workTextView2: UITextView = {
        let tv = UITextView(frame: CGRect(x: 50, y: 400, width: UIScreen.main.bounds.width, height: 200))
        tv.backgroundColor = UIColor.clear
        tv.tintColor = UIColor.white
        tv.textColor = UIColor.white
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.text = "2014年3月 - 2015年8月                                                                            公司：广州品星软件科技有限公司                                                                                                                                                       工作地点：广州                                                                                                                                                      职位：iOS实习生/iOS工程师                                                                            工作职责：主要是框架搭建和部分功能模块的开发，负责解决开发过程中的技术问题"
        //        tv.sizeToFit()
        return tv
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
