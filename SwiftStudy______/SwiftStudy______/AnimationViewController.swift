//
//  AnimationViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/20.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class AnimationViewController: BaseViewController {

    var myView : UIView?{
        get{
         let Vie = UIView(frame: CGRect(x: 10, y: 100, width: Screen_Width-20, height: 5))
             Vie.backgroundColor = UIColor.blue
             view.addSubview(Vie)
            return Vie
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        StartAnimation()
    }
    func StartAnimation(){
      var Animation: Bool = true
        
        
        UIView.animate(withDuration: 2.0) {
            Animation = !Animation
            if Animation == true{
//                self.myView?.frame = CGRect(x: 10, y: 400, width: Screen_Width-20, height: 5)
                
                self.myView?.transform = CGAffineTransform.init(translationX: 0, y: 300)
            }else{
//                self.myView?.frame = CGRect(x: 10, y: 100, width: Screen_Width-20, height: 5)
                self.myView?.transform = CGAffineTransform.identity
                
            }
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.view.layoutIfNeeded()
            
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
