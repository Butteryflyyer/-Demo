
//
//  subSecondViewController.swift
//  SwiftStudy______
//
//  Created by 信昊 on 17/3/2.
//  Copyright © 2017年 xinhao. All rights reserved.
//

import UIKit
import WebKit
class subSecondViewController: BaseViewController,WKScriptMessageHandler,WKNavigationDelegate{

    var webview:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.green
        // 创建WKWebView
        // 创建配置
        let config = WKWebViewConfiguration()
        // 创建UserContentController（提供JavaScript向webView发送消息的方法）
        let userContent = WKUserContentController()
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        userContent.add(self as WKScriptMessageHandler, name: "NativeMethod")
        // 将UserConttentController设置到配置文件
        config.userContentController = userContent
        
        let webView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 300), configuration: config)
        // 设置访问的URL
        webView.navigationDelegate = self
      
        // 根据URL创建请求
        let myurl = Bundle.main.path(forResource: "jsToOc", ofType: "html")!
       
        do {
             let myURL = try String(contentsOf:  NSURL.init(fileURLWithPath: myurl) as URL)

            // 加载js
            webView.loadHTMLString(myURL, baseURL: Bundle.main.bundleURL)
        } catch { }

        view.addSubview(webView)
        
        self.webview = webView

        
        let btn = UIButton.init(type: .contactAdd)
        
        btn.frame = CGRect(x: 0, y: 300, width: 100, height: 20)
        
        btn.addTarget(self, action: #selector(ThirdViewController.click), for: .touchUpInside)
        view.addSubview(btn)
        

        // Do any additional setup after loading the view.
    }

    func click(){
        self.webview?.evaluateJavaScript("showmyName()", completionHandler: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "NativeMethod"{
            print("myname")
      
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
