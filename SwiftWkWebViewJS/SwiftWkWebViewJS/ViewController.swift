//
//  ViewController.swift
//  SwiftWkWebViewJS
//
//  Created by 信昊 on 17/1/16.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate,WKScriptMessageHandler {

    var wkView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建配置
        let config = WKWebViewConfiguration()
        // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        let userContent = WKUserContentController()
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        userContent.add(self , name: "model")
        userContent.add(self, name: "anotherModel")
        // 将UserConttentController设置到配置文件
        config.userContentController = userContent
        // 高端的自定义配置创建WKWebView
        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        
//        // 设置访问的URL
        let url = NSURL(string: "https://www.baidu.com")
        // 根据URL创建请求
        let requst = NSURLRequest(url: url! as URL)
        // 设置代理
        webView.navigationDelegate = self
        // WKWebView加载请求
        webView.load(requst as URLRequest)

//        let htmlStr = try?String(contentsOfFile: Bundle.main.path(forResource: "jsDemo", ofType: "html")!)
//        webView.loadHTMLString(htmlStr!, baseURL: nil)
//        // 将WebView添加到当前view
        view.addSubview(webView)
//        
        wkView = webView
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    // 加载完成的代理方法
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        // 判断是否需要加载（仅在第一次加载）
      
            // 调用使用JS发送POST请求的方法
            postRequestWithJS()
            // 将Flag置为NO（后面就不需要加载了）
        
        
    }
    // 调用JS发送POST请求
    func postRequestWithJS() {
        // 发送POST的参数
        let postData = "\"userId\":\"1132\","
        // 请求的页面地址
        let urlStr = "https://www.zyskcn.com/qdw/weixin/luckdrawApp.html"
        // 拼装成调用JavaScript的字符串
        let jscript = "post('\(urlStr)', {\(postData)});"
        // 调用JS代码
        self.wkView?.evaluateJavaScript(jscript) { (object, error) in
            
            
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let test = message.body as? String
        
        if  test == "3333"{
            
            print("1111")
            
        }else{
            let dic = message.body as! NSDictionary
            showAlert(message: dic["yousay"] as! String)
            
        }
        
     
        
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "回答"
        }
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: {[weak self](alertAction) in
            let answer = alert.textFields?.first?.text
              let js = "answer('3333322223232323233223')"
            self?.wkView?.evaluateJavaScript(js, completionHandler: { (info, error) in
                print(info)
                print(error)
            })
            self?.wkView?.evaluateJavaScript("showAlert()", completionHandler: { (info, error) in
                
                print(info)
                
            })
            
            
            }))
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

