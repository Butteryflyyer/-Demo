//
//  ViewController.m
//  JSPatchDemo
//
//  Created by 信昊 on 17/1/6.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "ViewController.h"

typedef void (^testBlock)(id data);

@interface ViewController ()<UIAlertViewDelegate>
{
    
    NSString *_testStr;
    
}
@property(nonatomic,copy)NSString *titleStr;

@property(nonatomic,retain)NSMutableArray *muarr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSForegroundColorAttributeName);
    
   self.titleStr = @"str";
  
    [self testBlock:^(id data) {
       
        NSLog(@"%@",data);
    }];
    
    UIButton *btn;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    [self initsubviews];
    [self initProperty];
    
    [self testMyAddMethod];
    
}

-(void)initsubviews{
    
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    myview.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:myview];
    
    myview.frame = CGRectMake(0, 0, 0, 0);
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil];
    
    [alert show];
    
}

-(void)testMyAddMethod{
    
    
    
    
}

-(void)testBlock:(void(^)(id data))block{
    
    
    block(@"0");
    
    
}

+(testBlock)testB{
    testBlock blk = ^(id data){
        
        
        NSLog(@"%@",data);
        
    };
 
    
    
    return blk;
}

+(void)BackBlock:(testBlock)blk{
    
    blk(@"1111");
    
    
}
-(void)initProperty{
  
//    [self.muarr addObject:@"jspatch"];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
