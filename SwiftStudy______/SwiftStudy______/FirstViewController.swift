//
//  FirstViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SDCycleScrollView
import SnapKit
class FirstViewController: BaseViewController, SDCycleScrollViewDelegate{
    
    var BannerSource:[BannerModel?] = []
    
    var Urls: [String?] = [String?]()
    
    lazy var myScrollView: UIScrollView = {
       let scroll = UIScrollView.init(frame: CGRect(x: 0, y: 300, width: Screen_Width, height: 200))
        
        scroll.contentSize = CGSize(width: Screen_Width * 2, height: 0)
        scroll.delegate = self
        return scroll
        
    }()
    
    var mybanner : SDCycleScrollView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "前小米"
        
        NetworkTools.shareInstance.requestData(methodType: .POST, urlString: "http://www.zyskcn.com/qdw/banner/get.act?type=0", parameters: nil) {[unowned self] (response, error) in
            if error != nil {
                
            }else{
                
                let json = JSON(response)
                print(json)
                print(json["rtData"].description)
          
                let bannerArr  = JSONDeserializer<BannerModel>.deserializeModelArrayFrom(json: json["rtData"].description)
                
                self.BannerSource = bannerArr!
                
                print(bannerArr)
                
                for model in self.BannerSource{
                    
                    self.Urls.append((model?.banner)!)
                    
                }
                
                self.addBanner(BannerUrls: self.Urls as! [String])
            }
            
                self.addScrollView()
        }
        
    
        
        // Do any additional setup after loading the view.
    }

    func addBanner(BannerUrls:[String]){
        
        print(BannerUrls)
        let cycleView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 64, width: Screen_Width, height: 400), delegate: self, placeholderImage: nil)
        
        
            cycleView?.imageURLStringsGroup = BannerUrls
        
            cycleView?.pageControlStyle = SDCycleScrollViewPageContolStyleNone
        
            view.addSubview(cycleView!)
        
        mybanner = cycleView
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print("你选中了第\(index)张")
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
extension FirstViewController : UIScrollViewDelegate{
    
    func addScrollView(){
        
        view.addSubview(myScrollView)
        
        let firstbtn = UIButton.init(type: .custom)
        
        firstbtn.setTitle("first", for: .normal)
        firstbtn.setTitleColor(UIColor.red, for: .normal)
        firstbtn.addTarget(self, action: #selector(FirstViewController.firstClick), for: .touchUpInside)
        view.addSubview(firstbtn)
        
        let secondbtn = UIButton.init(type: .custom)
        
        secondbtn.setTitle("secondbtn", for: .normal)
        secondbtn.addTarget(self, action: #selector(FirstViewController.secondClick), for: .touchUpInside)
        secondbtn.setTitleColor(UIColor.gray, for: .normal)
        view.addSubview(secondbtn)
        
        firstbtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.view.snp.left).offset(0)
            make.top.equalTo(mybanner!.snp.bottom).offset(0)
            make.width.equalTo(Screen_Width/2)
            make.height.equalTo(20)
            
            
        }
        secondbtn.snp.makeConstraints { (make) in
            
            make.right.equalTo(self.view.snp.right).offset(0)
            make.top.equalTo(mybanner!.snp.bottom).offset(0)
            make.width.equalTo(Screen_Width/2)
            make.height.equalTo(20)
            
            
        }
        
        self.addChildViewController(subFirstViewController())
        
        self.addChildViewController(subSecondViewController())
        
      self.scrollViewDidEndScrollingAnimation(myScrollView)
        
  
        
    }
    
    func firstClick(){
        
        myScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func secondClick(){
        
        myScrollView.setContentOffset(CGPoint(x: Screen_Width, y: 0), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/Screen_Width)
        
        let willshowChildVc = self.childViewControllers[index]
        
        if willshowChildVc.isViewLoaded {
            return;
        }
        willshowChildVc.view.frame = scrollView.bounds
        
        scrollView.addSubview(willshowChildVc.view)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
        
        
    }
    
}
