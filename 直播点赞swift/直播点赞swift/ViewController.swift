//
//  ViewController.swift
//  直播点赞swift
//
//  Created by 信昊 on 16/11/10.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

let UIScreen_Width = UIScreen.main.bounds.size.width
let UIScreen_Height = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    var applauseBtn : UIButton?
    
    var applauseNumLbl : UILabel?
    
    var applauseNum : NSInteger = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func setUI() -> Void {
        
        applauseBtn = UIButton.init(frame: CGRect(x: UIScreen_Width-15-60, y: UIScreen_Height-80-60, width: 60, height: 60))
        
       applauseBtn?.contentMode = .scaleToFill
        applauseBtn?.setImage(UIImage.init(named: "applause"), for: .normal)
        applauseBtn?.setImage(UIImage.init(named: "applause"), for: .highlighted)
        
        
        applauseBtn?.addTarget(self, action: #selector(ViewController.applauseBtnClick), for: .touchUpInside)
        
        view.addSubview(applauseBtn!)
        
        
        applauseNumLbl = UILabel.init(frame: CGRect(x: 6, y: 43, width: 50, height: 12))
        
        applauseNumLbl?.textColor = UIColor.white
        applauseNumLbl?.font = UIFont.systemFont(ofSize: 12)
        applauseNumLbl?.text = "0"
        applauseBtn?.addSubview(applauseNumLbl!)
        applauseNumLbl?.textAlignment = .center
        
        
        
        
    }
    
    
    func applauseBtnClick() -> Void {
        
        applauseNum += 1
        
        applauseNumLbl?.text = String(applauseNum)
        
        self.ShowTheApplauseInView(view: view, v: applauseBtn!)
        
        
    }
    
    func ShowTheApplauseInView(view:UIView,v:UIButton) -> Void {
        
        let index = Int(arc4random_uniform(7))
        
        let imageStr = "applause_" + String(index)
        
        let applauseView = UIImageView.init(frame: CGRect(x: UIScreen_Width-65, y: UIScreen_Height-150, width: 40, height: 40))
        view.insertSubview(applauseView, belowSubview: v)
        
        applauseView.image = UIImage.init(named: imageStr)
        
        
        let AnimH = 350
        
        
        applauseView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        applauseView.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            applauseView.transform = CGAffineTransform.identity
            applauseView.alpha = 0.9
            
            
            }, completion: nil)
        
        
        let i = Int(arc4random_uniform(2))
        let rotationDirection = 1-(2*i)
        let rotationFraction =  Int(arc4random_uniform(10))
        
        UIView.animate(withDuration: 4) {
         applauseView.transform = CGAffineTransform(rotationAngle:CGFloat(rotationDirection*Int(M_PI)/(4 + rotationFraction*Int(0.2))))
           
        }
//
//        
//    
//  
        let heartTravelPath = UIBezierPath.init()
        
        heartTravelPath.move(to: applauseView.center)

//
        let Viewx : CGFloat = applauseView.center.x
        let Viewy : CGFloat = applauseView.center.y
        
        let endPoint : CGPoint = CGPoint(x: Viewx+CGFloat(rotationDirection * 10), y: Viewy - CGFloat(AnimH))
        
        
        let j = arc4random_uniform(2)
        let travelDirection = 1-(2-Int(j))
        let m1 : NSInteger = Int(Viewx) + travelDirection * (Int(arc4random_uniform(20))+50)
        let n1 : NSInteger = Int(Viewy) - 60 + travelDirection * Int(arc4random_uniform(20))
        let m2 : NSInteger = Int(Viewx) - travelDirection * (Int(arc4random_uniform(20))+50)
        let n2 : NSInteger = Int(Viewy)-90 + travelDirection * Int(arc4random_uniform(20))
        
        let controlPont1 = CGPoint(x: m1, y: n1)
        let controlPoint2 = CGPoint(x: m2, y: n2)
        
        heartTravelPath.addCurve(to: endPoint, controlPoint1: controlPont1, controlPoint2: controlPoint2)
        
        let keyFrameAnimation = CAKeyframeAnimation.init(keyPath: "position")
        
        keyFrameAnimation.path = heartTravelPath.cgPath
//
        keyFrameAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault)
        keyFrameAnimation.duration = 3
        
        applauseView.layer.add(keyFrameAnimation, forKey: "positionOnPath")
        
        UIView.animate(withDuration: 3, animations: { 
            applauseView.alpha = 0.0
            }) { (finished) in
                
                applauseView.removeFromSuperview()
        }
        
        
        
        
            
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

