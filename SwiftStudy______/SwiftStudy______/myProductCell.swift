//
//  myProductCell.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/2.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

class myProductCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var mylabel: UILabel?
    
    var areaLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mylabel = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        addSubview(mylabel!)
        
        areaLabel = UILabel()
        addSubview(areaLabel!)
        areaLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((mylabel?.snp.right)!).offset(10)
            make.centerY.equalTo((mylabel?.snp.centerY)!)
            make.width.equalTo(100)
            make.height.equalTo(50)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
