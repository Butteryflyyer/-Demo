//
//  SecondViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/1.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import JavaScriptCore
@objc protocol JavaScriptSwiftDelegate: JSExport{
    func show()
}
@objc class JSObjectModel : NSObject, JavaScriptSwiftDelegate {
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    var myblock : (()->())?
    
    func show() {
        print("js call objc method: callSystemCamera");
        
       myblock!()
       
    }   
}

class SecondViewController: BaseViewController {

    lazy var myWebView: UIWebView={[weak self] in
        var web = UIWebView.init(frame: CGRect(x: 0, y: 200, width: Screen_Width, height: Screen_Height))
        var myurl = Bundle.main.path(forResource: "jsToOc", ofType: "html")!
        var myURL = NSURL.init(string: myurl)
        web.delegate = self;
        web.loadRequest(URLRequest.init(url: myURL as! URL))
        web.scalesPageToFit = true
        var model = JSObjectModel()
        model.myblock = {()in
            
            print("jsdiaoyongoc");
        }
        
        let jsContext = web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
         jsContext?.setObject(model, forKeyedSubscript: "callSwift" as (NSCopying & NSObjectProtocol)!)
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的客户"
    
        view.addSubview(myWebView)
        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension SecondViewController: UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        
        webView.stringByEvaluatingJavaScript(from: "myclick()")

    }
    
}
