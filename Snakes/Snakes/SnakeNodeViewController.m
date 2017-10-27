//
//  SnakeNodeViewController.m
//  Snakes
//
//  Created by 信昊 on 2017/10/27.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import "SnakeNodeViewController.h"
#import "StakeView.h"
#import "SnakeBody.h"
@interface SnakeNodeViewController ()<StakeDelegate,SnakeMoveDelegate>
@property (strong, nonatomic)  UIView *backView;
@property (nonatomic,strong) SnakeBody *snakeBody;
@property (strong, nonatomic)  UILabel *scoreLable;
@property (nonatomic,strong) NSMutableArray<UIView*> *foods;
@property(nonatomic,assign) int score;

@property(nonatomic,strong) UIButton *resetart_btn;
@property(nonatomic,strong) UIButton *Zanting_btn;

@property(nonatomic,strong)UIView *obj;

@end

@implementation SnakeNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    [self prepareFoods];
    StakeView *s = [[StakeView alloc] initWithFrame:CGRectMake(40, [UIScreen mainScreen].bounds.size.height-140, 100, 100)];
    s.delegate = self;
    [self.view addSubview: s];
    _snakeBody = [[SnakeBody alloc] initWithView:self.view];
    _snakeBody.delegate = self;
    

    
    
    self.resetart_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetart_btn setTitle:@"重新开始" forState:UIControlStateNormal];
    [self.resetart_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.resetart_btn];
    self.resetart_btn.frame = CGRectMake(10, 10, 100, 20);
    
    self.Zanting_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Zanting_btn setTitle:@"开始" forState:UIControlStateNormal];
    [self.Zanting_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.Zanting_btn];
    self.Zanting_btn.frame = CGRectMake(10, 40, 100, 20);
    
    self.scoreLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 40, 20)];
    [self.backView addSubview:self.scoreLable];
    
    [self.resetart_btn addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    
      [self.Zanting_btn addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setScore:(int)score{
    _score = score;
    self.scoreLable.text = [NSString stringWithFormat:@"%d",score];
}
-(void)prepareFoods{
    self.score = 0;
    [self.foods enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.foods removeAllObjects];
    if (!self.foods) {
        self.foods = [NSMutableArray array];
    }
    for (int i =0; i<10; i++) {
        for (int j=0; j<10; j++) {
            int width = arc4random()%11+3;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
            view.backgroundColor = [UIColor colorWithRed:(random()%256)/256.0 green:(random()%256)/256.0 blue:(random()%256)/256.0 alpha:1];
            view.center = CGPointMake(random()%((int)[UIScreen mainScreen].bounds.size.width-30)+15, random()%((int)[UIScreen mainScreen].bounds.size.height-30)+15);
            view.layer.cornerRadius = width/2;
            [self.backView addSubview:view];
            [self.foods addObject:view];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stakeDidChange:(CGPoint)offset{
    if (offset.x==0&&offset.y==0) {
        return;
    }
    self.snakeBody.side = offset;
}
- (void)clickStart:(UIButton*)sender {
    sender.tag = !sender.tag;
    self.snakeBody.isMoving = sender.tag;
    [sender setTitle:(sender.tag?@"暂停":@"开始") forState:UIControlStateNormal];
}

-(void)snakeDidMove2Frame:(CGRect)rect{
    if (!CGRectContainsRect(self.view.bounds, rect)) {
        //超出边界
        [self restart:nil];
    }
    __weak typeof(self)weakself = self;
    [self.foods enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //碰撞检测
        if (CGRectContainsPoint(rect, obj.center)) {
            *stop=YES;
            
            [obj removeFromSuperview];
            [self.foods removeObject:obj];
            self.score+=obj.bounds.size.width/3;
            [self.snakeBody eatFoodCount:obj.bounds.size.width/3];

        }
    }];
}

- (void)restart:(id)sender {
    [self prepareFoods];
    [self.snakeBody reLife];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
