

require('UIView')
require('UIColor')
require('NSMutableArray')
require('mytestViewController')
defineClass('ViewController : UIViewController <UIAlertViewDelegate>',['mydic','testMuarr'],{
            
//            viewDidLoad: function(){
//            self.super().viewDidLoad();
//            
//            initSubviews();
//            
//            },
            initsubviews: function(){
            
            var myview = UIView.alloc().init();
            
            myview.setFrame({x:20, y:20, width:100,height:100});
            
        
            myview.setBackgroundColor(UIColor.redColor());
            
            self.view().addSubview(myview);

            
            
            },
            initProperty: function(){
            
    
            self.setTitleStr("str");
            
           var myString = self.titleStr();
            

            
      
            self.muarr().toJS().push("jspatch");
            
        
            self.setMuarr(NSMutableArray.alloc().init());
            
            self.muarr().addObject("jspatch");
            
            console.log(self.muarr().toJS());
            
            
            self.setMydic({"name":"test"});
            
            console.log(self.mydic());
            
//            
            self.setTestMuarr(NSMutableArray.alloc().init());
            
            
            self.testMuarr().addObject("testMuar");
            
            console.log(self.testMuarr().toJS());
            
            
            self.setValue_forKey("myname","_testStr");
            
            console.log(self.valueForKey("_testStr"));
            
            },
            
            
// 协议
            testMyAddMethod:function(){
            
            require("UIAlertView");
            
            var alert = UIAlertView.alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("1", "2", self, "3", "4", null);
            
            alert.show();
            
            
           
            
            
            },
            alertView_clickedButtonAtIndex: function(alertView, buttonIndex) {
            //跳转到其他界面
            var vc = mytestViewController.alloc().init();
            
            self.presentViewController_animated_completion(vc, YES, null);
            
             console.log("addMethod");
            
    
            
            var blk = require('ViewController').testB();
            
            blk("222");
            
            require('ViewController').backBlock(block("id",blk));
            
         
            },
            testBlock: function(block) {
            
            block("0");
            
            
            
            }

            
            },{
            
            
            });


require('UIButton')
defineClass('mytestViewController: UIViewController',{
            
            viewDidLoad:function(){
            
            var btn = UIButton.buttonWithType(0);
            btn.setFrame({x:100,y:100,width:100,height:100});
            
            btn.setBackgroundColor(UIColor.blueColor());
            
            btn.addTarget_action_forControlEvents(self,"click",1<<6);
            
            self.view().addSubview(btn);
            
            self.view().setBackgroundColor(UIColor.whiteColor());
            
            
            },
            click:function(){
            
           self.dismissViewControllerAnimated_completion(YES, null);
            
            }
            
            
            
            },{
            
            
            
            });


