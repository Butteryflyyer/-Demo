//
//  ThirdViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit

let Screen_Width = UIScreen.main.bounds.width
let Screen_Height = UIScreen.main.bounds.height

let CustomCellIdentity = "myCustomCell"
class ThirdViewController: BaseViewController {
    
    var HereBlock:((_ name: String?)->Void)?
    
    lazy var myTableView : UITableView = {
        
       let table = UITableView.init(frame: CGRect(x: 0, y: 64, width: Screen_Width, height: 150), style: .plain)
        
        table.delegate = self
        table.dataSource = self
//        table.backgroundColor = UIColor.red
     
        table.register(myCustomCell.self, forCellReuseIdentifier: CustomCellIdentity)
        
        return table
        
    }()
    
    lazy var myBlockview : BlockView = {
       
        let myView = BlockView.init(frame: CGRect(x: 0, y: 214, width: Screen_Width, height: 100))
        
            myView.backgroundColor = UIColor.gray
        
        myView.myBlock = {
            (name : String?) in
            if var myname = name{
                print(myname)
                
        
            }
        
        }
        
        return myView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        AddTableView()
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AddTableView(){
        
        
     view.addSubview(myTableView)
     
     view.addSubview(myBlockview)
     
        
        let btn = UIButton.init(type: .contactAdd)
        
        btn.frame = CGRect(x: 0, y: 300, width: 100, height: 20)
        
        btn.addTarget(self, action: #selector(ThirdViewController.click), for: .touchUpInside)
        view.addSubview(btn)
        
        
        let btnRuntime = UIButton.init(type: .contactAdd)
        
        btnRuntime.frame = CGRect(x: 0, y: 400, width: 100, height: 20)
        
        btnRuntime.xh_acceptEventInterval = 5.0
        
        btnRuntime.xh_ignoreEvent = false
        
        btnRuntime.addTarget(self, action: #selector(ThirdViewController.runtimeclick), for: .touchUpInside)
        view.addSubview(btnRuntime)
        
    }
    
    func click() -> Void {
       
        self.present(subSecondViewController(), animated: true, completion: nil)
        
    }
    func runtimeclick() -> Void{
        
         print("click")
//        self.present(RunTimeViewController(), animated: true, completion: nil)
    }
  
}
extension ThirdViewController : UITableViewDelegate,UITableViewDataSource{
    
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentity) as? myCustomCell
        
        if cell == nil {
            cell = myCustomCell.init(style: .default, reuseIdentifier: CustomCellIdentity)
        }
 
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(AnimationViewController(), animated: true)
        
        print(indexPath.row)
        
    }
    
}
