//
//  SinglePickView.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/26.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "SinglePickView.h"
#import "UIView+SDAutoLayout.h"
@interface SinglePickView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    CGRect Frame;
    
    NSMutableArray *OneArr;
    
    NSDictionary *TwoDic;
    
    NSMutableArray *TwoSelectArr;
    
    
}


@end

@implementation SinglePickView
-(instancetype)initWithFrame:(CGRect)frame WithOneArr:(NSArray *)oneArr{
    
    if (self = [super initWithFrame:frame]) {
        Frame = frame;
        
        
        OneArr = [NSMutableArray arrayWithArray:oneArr];
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        self.backView.backgroundColor = [UIColor blackColor];
        
        self.backView.alpha = 0.5;
        
        [self addSubview:self.backView];
        self.backBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height, SCREEN_WIDTH, Real(280))];//260
          self.backBottomView.backgroundColor = _COLOR_RGB(0xffffff);
        [self addSubview:self.backBottomView];
        
        
        self.backgroundColor = [UIColor clearColor];
        
     
        
    
        
        [self initPicker];
        [self initSubview];
        
//        [QDWTools StartTishiAnimationWithY:SCREEN_HEIGHT-190 WithView:self.backBottomView];
        [UIView animateWithDuration:1 animations:^{
            self.backBottomView.frame = CGRectMake(0, SCREEN_HEIGHT-Real(280), SCREEN_WIDTH, Real(280));
            
        } completion:^(BOOL finished) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGesture)];
            
            [self.backView addGestureRecognizer:tap];
        }];
        

    
        
        
        
    }
    return self;
    
}
-(void)TapGesture{

    [UIView animateWithDuration:1 animations:^{
        self.backBottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, Real(280));
        
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        
        [self removeFromSuperview];
    }];

      

}

-(void)initPicker{
    

    
    NSInteger selectedIndex = [self.pickView selectedRowInComponent:0];
    NSString *seletedCategory = [OneArr objectAtIndex:selectedIndex];

    
    self.OneComponentStr = seletedCategory;
    
    NSLog(@"%@",TwoSelectArr);
    
}
-(void)initSubview{
    
    [self.backBottomView addSubview:self.pickView];
    
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    backView.backgroundColor = _COLOR_RGB(0xf7f7f8);
    
    backView.alpha = 1;
    [self.backBottomView addSubview:backView];
    
    
    [backView addSubview:self.CancelButton];
    [backView addSubview:self.SuccessButton];
    
    self.CancelButton.sd_layout.leftSpaceToView(backView,10).heightIs(20).centerYEqualToView(backView).widthIs(40);
    
    self.SuccessButton.sd_layout.rightSpaceToView(backView,5).centerYEqualToView(backView).heightIs(20).widthIs(60);

    [self.CancelButton addTarget:self action:@selector(TapGesture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SuccessButton addTarget:self action:@selector(TapGesture) forControlEvents:UIControlEventTouchUpInside];
    
}
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
    
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    if (component == 0) {
        return OneArr.count;
    }
    return 0;
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return SCREEN_WIDTH/2;
    }
 
    
    
    return 0;
}
/************************重头戏来了************************/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [OneArr objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:Real(20)];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    return myView;
    
}



//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        
       
      
        
        
        return OneArr[row];
    }
    
 
    
    
    return nil;
}
//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSString *seletedStr = [OneArr objectAtIndex:row];
  

 
        
        self.OneComponentStr = seletedStr;
        
 
        
    }
 
}
//设置列里边组件的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
 
    return 40;
}

-(UIPickerView *)pickView{
    
    if (!_pickView) {
        
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, Frame.size.width, Real(260)-40)];
        // 显示选中框
        _pickView.showsSelectionIndicator=YES;
        _pickView.dataSource = self;
        _pickView.delegate = self;
        

        
        _pickView.backgroundColor = _COLOR_RGB(0xffffff);
        
    }
    return _pickView;
    
}
-(UIButton *)CancelButton{
    if (!_CancelButton) {
        
        _CancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_CancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        _CancelButton.titleLabel.font = FontSystem(15);
        
        [_CancelButton setTitleColor:_COLOR_RGB(0xff4d00) forState:UIControlStateNormal];
        
   ;
    }
    
    return _CancelButton;
}
-(UIButton *)SuccessButton{
    if (!_SuccessButton) {
        
        _SuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_SuccessButton setTitle:@"完成" forState:UIControlStateNormal];
        
        _SuccessButton.titleLabel.font = FontSystem(15);
        
        [_SuccessButton setTitleColor:_COLOR_RGB(0xff4d00) forState:UIControlStateNormal];
        
      
    }
    
    return _SuccessButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
