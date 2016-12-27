//
//  ViewController.m
//  长按手势复制
//
//  Created by 信昊 on 16/12/21.
//  Copyright © 2016年 xinhao. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+copy.h"
#import "CustomCell.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CustomCellDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *testlabel;

@property(nonatomic,strong)UIWebView *webview;

@property(nonatomic,copy)NSString *myname;

@property(nonatomic,strong)NSString *myStrongName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.testlabel.isCopyable = YES;
//
//    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 480, 500) style:UITableViewStylePlain];
//    
//    table.delegate = self;
//    table.dataSource = self;
//    
//    [self.view addSubview:table];
//    
  
    NSMutableString *nameMu = [[NSMutableString alloc]init];
    
    nameMu.string = @"name";
    
    self.myname = nameMu;
    
    
    NSLog(@"%@",self.myname);
    
    nameMu.string = @"test";
    
    NSLog(@"%@,%p",self.myname,self.myname);
    
    
    
    
  NSMutableString *Strongname = [[NSMutableString alloc]init];
    Strongname.string = @"strongname";
    self.myStrongName = Strongname;
    
    NSLog(@"%@, %p", self.myStrongName, self.myStrongName);
    
    Strongname.string = @"1";
    
     NSLog(@"%@",self.myStrongName);
    
    
    NSString *copystr = @"copy";
    
    NSMutableString *mucopyStr = [copystr mutableCopy];
    
    
    NSLog(@"-------%p,%p",copystr,mucopyStr);
    NSLog(@"-------%@,%@",copystr,mucopyStr);
    
    mucopyStr.string = @"1";
    NSLog(@"-------%@,%@",copystr,mucopyStr);
    
    
    
    
    
     self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
       self.webview .delegate = self;
//    webview.scalesPageToFit = YES;// 适应手机
    [self.view addSubview:self.webview ];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"js交互"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webview  loadHTMLString:htmlCont baseURL:baseURL];

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"onlog"] = ^(){
        
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsval in args) {
            
            NSLog(@"%@",jsval.toString);
            
            
        }
      
        
        
        
    };
    
    
    
    
    
    
}


- (IBAction)change:(id)sender {
    
//    [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('button')[0].innerHTML = '1000'"];
    
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('img')[0].src = 'fb.png'"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"1"];
    }
    
    cell.delegate = self;
//    cell.textLabel.text = @"1";
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 30;
}
-(void)CopyordeleteWithString:(NSString *)str{
    
    
    NSLog(@"%@",str);
    
}



//
//-(BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    return YES;
//}
////每个cell都会点击出现Menu菜单
//
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//
//{
//  
//    return YES;
// 
//}
//
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
//
//{
//
//    if (action == @selector(copy:)) {
//    
////        [UIPasteboard generalPasteboard].string = [self.array objectAtIndex:indexPath.row];
//  
//    }
//
//    if (action == @selector(cut:)) {
//    
////        [UIPasteboard generalPasteboard].string = [self.array objectAtIndex:indexPath.row];
//// 
////        [self.array replaceObjectAtIndex:indexPath.row withObject:@""];
////  
////        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//
//    }
//
//    if (action == @selector(paste:)) {
// 
////        NSString *pasteString = [UIPasteboard generalPasteboard].string;
////
////        NSString *tempString = [NSString stringWithFormat:@"%@%@",[self.array objectAtIndex:indexPath.row],pasteString];
////    
////        [self.array replaceObjectAtIndex:indexPath.row withObject:tempString];
////   
////        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//  
//    }
//
//}
//
//






- (IBAction)click:(id)sender {
    
    UIPasteboard *pase = [UIPasteboard generalPasteboard];
    
    NSLog(@"%@",pase.string);
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
