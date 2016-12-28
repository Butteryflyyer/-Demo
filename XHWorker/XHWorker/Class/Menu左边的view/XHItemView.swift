//
//  XHItemView.swift
//  XHWorker
//
//  Created by 信昊 on 16/12/27.
//  Copyright © 2016年 xinhao. All rights reserved.
//

import UIKit

class XHItemView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    var isAnimating = false
    var originalX : CGFloat = 0
    var originalY : CGFloat = 0
    var isShow = false
    var titleString:String!
    var isSelected: Bool{
        didSet{
            if isSelected {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
            }else{
                
                UIView.animate(withDuration: 0.4, animations: { 
                    self.layer.cornerRadius = 20
                    self.layer.shadowOpacity = 0.6
                    
                })
                
            }
            
            
        }
        
    }
    // 用来切换控制器
    var showDetail:((_ v:UIView)->())?
    
    init(frame: CGRect,title:String,img:UIImage) {
        isSelected = false
        super.init(frame: frame)
        
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.6
        
        
        
        titleString = title
        originalX = self.center.x
        originalY = self.center.y
        
        let titlelabel = UILabel()
        titlelabel.textColor = UIColor.white
        titlelabel.text = title
        titlelabel.frame = CGRect(x: 40, y: 0, width: self.bounds.width/2, height: self.bounds.height)
        titlelabel.font = UIFont(name: "Helvetica", size: 14.0)
        titlelabel.textAlignment = NSTextAlignment.left
        
        self.addSubview(titlelabel)
        
        let imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 112, y: 14, width: 45, height: 45)

        imageView.isUserInteractionEnabled = true
        self.addSubview(imageView)

        let tap = UITapGestureRecognizer(target: self, action:#selector(XHItemView.tapHandel(tap:)))
        addGestureRecognizer(tap)
        
        tap.numberOfTapsRequired = 2
        tap.numberOfTouchesRequired = 1
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(XHItemView.panHandel(tap:))))
        
        
        
        
    }
    
    @objc func panHandel(tap : UIPanGestureRecognizer){
        
        
        
        
    }
    
    
    @objc func tapHandel(tap: UITapGestureRecognizer){
        
        if isAnimating || isSelected{
            
            return
        }
        isAnimating = true
        
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: UIViewAnimationOptions.allowAnimatedContent, animations: { 
            
            self.center.x += 70
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1.2)
            }) { (_) in
                //停顿
             Utils.delay(seconds: 0.5, completion: { 
                
                self.showDetail?(self)
                
                
                self.isAnimating = false
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: UIViewAnimationOptions.allowAnimatedContent, animations: { () -> Void in
                    
                    self.center.x -= 70
                    self.transform = CGAffineTransform.identity
                    
                    },completion: nil)
                

                
             })
                
                
        
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}

class Utils {
    
    static var width:CGFont?
    
    class func delay(seconds: Double, completion:@escaping ()->()){
        
        
        //延时1秒执行
        let time: TimeInterval = seconds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("1 秒后输出")
        
            completion()
            
            
            
        }
    
    
}
}

