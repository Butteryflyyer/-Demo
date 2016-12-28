//
//  XHMainViewController.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit
import SnapKit
class XHMainViewController: UIViewController {
    let bgColor = UIColor(red: 00/255, green: 41/255,  blue: 82/255,   alpha: 1.0)

    var homeVC: UIViewController?
    var menuVc: XHMenuViewController?
    
    fileprivate lazy var scrollView: UIScrollView = {
        let sc = UIScrollView(frame: UIScreen.main.bounds)
        sc.delegate = self
        sc.bounces = false
        sc.isPagingEnabled = true
        sc.showsVerticalScrollIndicator = false
        sc.showsHorizontalScrollIndicator = false
        
        return sc
        
        
    }()
    
    fileprivate lazy var containView: UIView = {
        
        let sv = UIView(frame: UIScreen.main.bounds)
        
        return sv
        
    }()
    
    fileprivate lazy var detailView : UIView = {
        
        let sv = UIView(frame: UIScreen.main.bounds)
        
        return sv
        
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.setContentOffset(CGPoint(x: (menuVc?.view.bounds.size.width)!, y: 0), animated: false)
        
        scrollView.contentSize = CGSize(width: view.frame.size.width + (menuVc?.view.bounds.width)!, height: 0)
    }
    

  
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
      view.backgroundColor = bgColor
      self.navigationController?.isNavigationBarHidden = true
      
        setUpUI()
        
        
        switchChildViewControl()
        
        
        // Do any additional setup after loading the view.
    }

    
    func setUpUI(){
    
        
       view.addSubview(scrollView)
        scrollView.addSubview(containView)
        scrollView.addSubview(detailView)
        menuVc = XHMenuViewController()
        homeVC = XHBaseInfoViewController()
        addChildViewController(menuVc!)
        addChildViewController(homeVC!)
        
        detailView.addSubview(homeVC!.view)
        scrollView.addSubview((menuVc?.view)!)
        
        
        detailView.snp_makeConstraints { (make) in
            
            make.right.top.bottom.equalTo(scrollView)
            
            make.left.equalTo(menuVc!.view.snp_right)
            
            
        }
        
        menuVc!.view.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(containView)
            
            make.width.equalTo(70)
            
            
        }
        homeVC!.view.snp_makeConstraints { (make) in
            
            make.edges.equalTo(0)
            
        }
        
        
    
    }
    
    func switchChildViewControl(){
        
        
        if let menuVC = menuVc{
            
            menuVC.showDetail = {    v in
            
                  self.toggleMenu()
                
                  let myV = v as! XHItemView
                
                for otV in (myV.superview?.subviews)!{
                    
                    if let otV = otV as? XHItemView {
                        
                        if otV == myV {
                            otV.isSelected = true
                            
                        }else{
                            
                            otV.isSelected = false
                            
                        }
                        
                        
                    }
                    
                    
                }
             
                UIView.animate(withDuration: 0.3, animations: { 
                    myV.center = CGPoint(x: self.view.frame.width/2, y: -100)
                    myV.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                    
                    
                    }, completion: { (_) in
                        myV.transform = CGAffineTransform.identity
                        myV.center.x = myV.originalX
                        myV.center.y = myV.originalY
                        
                        var details: XHBaseViewController!
                        switch(myV.titleString) {
                            
                        
                            
                        case XHMenuItem.ResumeInfomation.BaseInfo.rawValue: // 基本信息
                            details = XHBaseInfoViewController()
                        case XHMenuItem.ResumeInfomation.OccupationalIntent.rawValue: // 职业意向
                            details = XHOccupationalVC()
                        case XHMenuItem.ResumeInfomation.PersonalProfile.rawValue:  // 个人优势
                            details = XHPersonalProfileVC()
                        case XHMenuItem.ResumeInfomation.EducationExperience.rawValue: // 教育经历
                            details = XHEducationExperienceVC()
                        case XHMenuItem.ResumeInfomation.LanguageSkill.rawValue: // 语言能力
                            details = XHLanguageSkillVC()
                        case XHMenuItem.ResumeInfomation.WorkExperience.rawValue: // 工作经历
                            details = XHWorkExperienceVC()
                        case XHMenuItem.ResumeInfomation.ProjectExperience.rawValue: // 项目经验
                            details = XHProjectExperenceVC()
                        case XHMenuItem.ResumeInfomation.Skills.rawValue: // 技巧
                            details = XHSkillsVC()
                        case XHMenuItem.ResumeInfomation.AdditionalInfo.rawValue: // 附加信息
                            details = XHAdditionalInfoViewController()
                            
                   
                            
                        default:
                            break
                        }

                        
                        details.view.backgroundColor = myV.backgroundColor
                        self.menuVc?.view.backgroundColor = myV.backgroundColor
                        self.addChildViewController(details)
                        
                        self.transition(from: self.homeVC!, to: details, duration: 0.4, options: UIViewAnimationOptions.transitionCurlDown, animations: { 
                            
                            }, completion: { (_) in
                                
                                self.homeVC!.removeFromParentViewController()
                                
                                self.homeVC = details
                                
                                
                                
                        })
                        
                        
                        
                        
                })
                
                
                
                
                
            }
            
           
            
          }
        
        
        
        
        
    }
    
    // 界面切换时负责滚动到合适位置
    fileprivate func toggleMenu() {
        let menuOffsetX = menuVc!.view.bounds.width
//        scrollView.contentOffset = CGPointMake((scrollView.contentInset.left == 0 ? menuOffsetX : 0), 0)
      
        scrollView.contentOffset = CGPoint(x: (scrollView.contentInset.left == 0 ? menuOffsetX : 0), y: 0)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    


}
extension XHMainViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
        
        
        
    }
    
    
    
}
