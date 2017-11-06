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
@property(nonatomic,strong) UIButton *tuichu_btn;

@property(nonatomic,strong)UIView *obj;

@end

@implementation SnakeNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self clickStart:self.Zanting_btn];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
       self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
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
    
    [self.view bringSubviewToFront:s];
    
    
    self.resetart_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetart_btn setTitle:@"restart" forState:UIControlStateNormal];
    [self.resetart_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.resetart_btn.layer.borderColor = _COLOR_RGB(0x333333).CGColor;
    self.resetart_btn.layer.borderWidth = 1;
    [self.backView addSubview:self.resetart_btn];
    self.resetart_btn.frame = CGRectMake(10, 40, 100, 20);
    
    self.Zanting_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Zanting_btn setTitle:@"start" forState:UIControlStateNormal];
    [self.Zanting_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.Zanting_btn];
    self.Zanting_btn.layer.borderColor = _COLOR_RGB(0x333333).CGColor;
    self.Zanting_btn.layer.borderWidth = 1;
    self.Zanting_btn.frame = CGRectMake(10, 80, 100, 20);
    
    self.tuichu_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tuichu_btn setTitle:@"exit" forState:UIControlStateNormal];
//    [self.tuichu_btn setImage:IMG(@"tuichu") forState:UIControlStateNormal];
    self.tuichu_btn.layer.borderColor = _COLOR_RGB(0x333333).CGColor;
    self.tuichu_btn.layer.borderWidth = 1;
    [self.tuichu_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backView addSubview:self.tuichu_btn];
    self.tuichu_btn.frame = CGRectMake(SCREEN_WIDTH-70, 50, 50, 50);
    
    [self.backView bringSubviewToFront:self.tuichu_btn];
    [self.backView bringSubviewToFront:self.scoreLable];
    self.scoreLable = [[UILabel alloc]init];
    self.scoreLable.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.scoreLable];
    [self.scoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView.mas_centerX);
        make.top.mas_equalTo(self.backView.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    self.scoreLable.font = FontSystem(20);
    self.scoreLable.font = FontBold(30);
    [self.backView bringSubviewToFront:self.scoreLable];
    [self.resetart_btn addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.Zanting_btn addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.tuichu_btn addTarget:self action:@selector(tuichuStart:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [sender setTitle:(sender.tag?@"pause":@"resume") forState:UIControlStateNormal];
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
-(void)tuichuStart:(id)sender{
    if ([self.Zanting_btn.titleLabel.text isEqual:@"resume"]|[self.Zanting_btn.titleLabel.text isEqual:@"start"]) {
        
    }else{
        [self clickStart:self.Zanting_btn];
    }
   
    [Tools ShowTishiAlertControllerWithTitle:@"prompt" AndDetial:@"do you want to exit your game?" WithView:self WithCancelTitle:@"cancel" WithMakeSureTitle:@"make sure" CancelActionBlock:^(id data) {
        
    } MakSureActionBlock:^(id data) {
        
           [self.navigationController popViewControllerAnimated:YES];
    }];

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
