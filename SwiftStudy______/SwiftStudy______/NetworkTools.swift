//
//  NetworkTools.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import Alamofire


enum RequestType: Int {
    case GET
    case POST
}

class NetworkTools: NSObject {

    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        
        return tools
    }()
    
    
}
extension NetworkTools{
    
    
    func requestData(methodType: RequestType, urlString: String, parameters: [String: AnyObject]?,finished: @escaping (_ result: AnyObject?, _ error: NSError?) ->()){
        
        let requestCallBlock = {(response : DataResponse<Any>) in
            if response.result.isSuccess {
             
                finished(response.result.value as AnyObject?,nil)
            }else{
                
                finished(nil,response.result.error as NSError?)
            }
        }
        
        
        let httpMethod: HTTPMethod = methodType == .GET ? .get : .post
        
        request(urlString, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: requestCallBlock)
        
        
    }
    
    
    
}
