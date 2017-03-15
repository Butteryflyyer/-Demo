
//
//  BlockView.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class BlockView: UIView {
    var myBlock:((_ name: String?)->Void)?
    
    lazy var mybtn : UIButton = {
       
        let btn = UIButton.init(type:.contactAdd)
        
            btn.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
            btn.addTarget(self, action: #selector(BlockView.Click), for: .touchUpInside)
        
            return btn
    }()
    
    
    
    override init(frame: CGRect) {
      
        super.init(frame: frame)
        
        addSubview(mybtn)
        
        
        
    }
    
    func Click(){
        
        myBlock!("testName")
        
        SwiftToOc.swiftToOC()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
