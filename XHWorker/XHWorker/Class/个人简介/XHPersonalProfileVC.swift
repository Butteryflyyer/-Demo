//
//  XHPersonalProfileVC.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHPersonalProfileVC: XHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置子控件
        setUpUI()
        
        // 设置各个控件的transform
        titleLabel.transform =  CGAffineTransform.init(translationX: 0, y: -100)
        titleLabel.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 8, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.titleLabel.transform = CGAffineTransform.identity
            self.titleLabel.alpha = 1
        }) { (_) -> Void in
            UIView.animate(withDuration: 3, animations: { () -> Void in
                self.textView.snp_updateConstraints({ (make) -> Void in
                    make.height.equalTo(500)
                })
                self.view.layoutIfNeeded()
            })
        }
    }
    // MARK:- 内部控制方法
    private func setUpUI() {
        view.addSubview(titleLabel)
        view.addSubview(textView)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.width.equalTo(view)
            make.height.equalTo(30)
            make.top.equalTo(view).offset(25)
        }
        textView.snp_makeConstraints { (make) -> Void in
            let width = UIScreen.main.bounds.width - 40
            make.width.equalTo(width)
            make.center.equalTo(view)
            make.height.equalTo(0)
        }
    }


    // MARK:- lazy
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 32)
        lb.textColor = UIColor.red
        lb.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0)
        lb.text = "职业意向"
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    private var textView: UITextView = {
        let tv = UITextView()
        tv.text = "自己是从13年暑假开始自学逐渐的接触iOS知识,然后开始自学ObjectiveIve-C。目前已经熟练ObjectiveIve-C进行开发的基础上,现在主攻Swift。可以把OC的代码用Swift写，但是还不算很熟悉。swift虽然比较新，关于swift基础语法到结构体枚举面向对象 。由于这些在其他语言也是相通的，所以理解起来也没什么压力 ，自己也对Swift的一些基础在简书上做了总结。                                                                                                                                                                                                                                                                                                                      熟练掌握OC。对AutoLayout比较熟悉，也熟练使用Masonry做约束，平时做得界面都是基于约束的。对动画 --------------------------------------------                                   比较熟悉能熟练做出各种动画效果。掌握内存管理机制，掌握多线程的GCD和NSOperattion,对于runtime运行时机制有一定的了解，对于kvc,kvo，Block,以及代理熟悉并且运用，了解第三方工具的友盟推送和分享，支付和地图。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            --------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        用过CocoaPods管理第三方库，可以自己自定义转场下拉刷新等。熟练使用SVN和GIT对App的版本控制，进行团队合作开发。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              --------------------------------------------                                            现在期望找到一份iOS相关的工作，最好是使用Swift写的。因为现在Swift作为苹果比较推崇的一个语言必然是以后的趋势，而且国外swift已经发展的比较成熟。苹果也有意将swift开源，可以看出其决心。写了这么多其实只是想求个机会 ， 因为各个语言之间的障碍并不是那么大，编程的思想是相通的。而且我也是决心投入iOS开发 ，为之也付出了很多努力，希望碰到自己的伯乐！"
        tv.backgroundColor = UIColor.clear
        tv.tintColor = UIColor.white
        tv.textColor = UIColor.white
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
