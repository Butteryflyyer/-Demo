//
//  subFirstViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/2.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
let identity = "myProductCell"

class subFirstViewController: BaseViewController {

    var ModelSource : [OrgModel?] = [OrgModel?]()
    
    lazy var mytableView: UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 300), style: .plain)
        
        table.delegate = self
        table.dataSource = self
        //        table.backgroundColor = UIColor.red
        
        table.register(myProductCell.self, forCellReuseIdentifier: identity)
      
        
        
        return table

        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(mytableView)
        loadData()
        
        // Do any additional setup after loading the view.
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
extension subFirstViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ModelSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identity) as? myProductCell
        if cell == nil {
            cell = myProductCell.init(style: .default, reuseIdentifier: identity)
        }
        let orgmodel: OrgModel? = self.ModelSource[indexPath.row]
        
        cell?.mylabel?.text = orgmodel?.Product_name!
        cell?.areaLabel?.text = orgmodel?.Area!
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension subFirstViewController{
    
    func loadData(){

        
        NetworkTools.shareInstance.requestData(methodType: .POST, urlString: "http://app.qiandaowei.com/qdw/OrganizationProductController/PreciseinquiryProduct.act?", parameters: ["page":"1" as AnyObject,"pageSize":"10" as AnyObject,"area":"北京" as AnyObject,"type":"1" as AnyObject]) {[unowned self] (response, error) in
            
            if error != nil{
                
            }else{
                let json = JSON(response)
                
                print(json)
                
                let OrgModelSource = JSONDeserializer<OrgModel>.deserializeModelArrayFrom(json: json["rtData"].description)
                
                guard let orgmodelsource = OrgModelSource else{
                    return
                }
                
                self.ModelSource = orgmodelsource
                
                let model = self.ModelSource.first!
                
                print(model?.Area!)
                print(model?.Product_name!)
                
               DispatchQueue.main.async(execute: { 
                self.mytableView.reloadData()
               })
                
            }
            
        }
    }
    
    
}

class OrgModel: HandyJSON {
    
    var Product_name: String? = ""
    
    var Area: String? {
        didSet{
           
            print(Area)
        }
     
        
    }
    
    required init(){
        
    }
}
