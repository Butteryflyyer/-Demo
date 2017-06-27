//
//  CustomPickView.m
//  QianDaoWeiApp
//
//  Created by 信昊 on 16/5/25.
//  Copyright © 2016年 信昊. All rights reserved.
//

#import "CustomPickView.h"

@interface CustomPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>

{

    CGRect Frame;
    
    NSMutableArray *OneArr;
    
    NSDictionary *TwoDic;
    
    NSMutableArray *TwoSelectArr;
    
    
}

@end

@implementation CustomPickView


-(instancetype)initWithFrame:(CGRect)frame WithOneArr:(NSArray *)oneArr WithTwoArr:(NSDictionary *)twodic{

    if (self = [super initWithFrame:frame]) {
        Frame = frame;
        self.TopbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        self.TopbackView.backgroundColor = [UIColor blackColor];
        
        self.TopbackView.alpha = 0.5;
        
        [self addSubview:self.TopbackView];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.backBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height, SCREEN_WIDTH, QDWRealValue(280))];//260
        
        self.backBottomView.backgroundColor = _COLOR_RGB(0xffffff);
        
        [self addSubview:self.backBottomView];

        
        OneArr = [NSMutableArray arrayWithArray:oneArr];
        
        TwoDic = [NSDictionary dictionaryWithDictionary:twodic];
        [self initPicker];
        [self initSubview];
        
        [UIView animateWithDuration:Time_SelectedTools animations:^{
            self.backBottomView.frame = CGRectMake(0, SCREEN_HEIGHT-QDWRealValue(280), SCREEN_WIDTH, QDWRealValue(280));
            
        } completion:^(BOOL finished) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGesture)];
            
            [self.TopbackView addGestureRecognizer:tap];
        }];
        

        
    }
    return self;

}
-(void)TapGesture{
    
    [UIView animateWithDuration:Time_SelectedTools animations:^{
        self.backBottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, QDWRealValue(260)-40);
        
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
    
    
    
}
-(void)initPicker{

    TwoSelectArr = [[NSMutableArray alloc]init];
    
    NSInteger selectedIndex = [self.pickView selectedRowInComponent:0];
    NSString *seletedCategory = [OneArr objectAtIndex:selectedIndex];
    TwoSelectArr = [TwoDic objectForKey:seletedCategory];
    
   
    
    if (OneArr.count == [[TwoDic allKeys]count]) { // 判断第一个列表和第二个列表中的数组个数是否相等
        self.OneComponentStr = seletedCategory;
        self.TwoComponentStr = TwoSelectArr[0];
        
    }else{
        
     self.OneComponentStr = seletedCategory;
    
    }
    

}
-(void)initSubview{

   [self.backBottomView addSubview:self.pickView];

    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];//40
    
   self.backView.backgroundColor = _COLOR_RGB(0xf7f7f8);
    
    [self.backBottomView addSubview:self.backView];
    
    [self.backView addSubview:self.CancelButton];
    [self.backView addSubview:self.SuccessButton];
    
    
    self.CancelButton.sd_layout.leftSpaceToView(self.backView,10).heightIs(20).centerYEqualToView(self.backView).widthIs(40);
    
    self.SuccessButton.sd_layout.rightSpaceToView(self.backView,0).centerYEqualToView(self.backView).heightIs(20).widthIs(60);
    [self.CancelButton addTarget:self action:@selector(TapGesture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SuccessButton addTarget:self action:@selector(TapGesture) forControlEvents:UIControlEventTouchUpInside];

}


// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

        return 2;

  
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    

        if (component == 0) {
            return OneArr.count;
        }else{
        
         return [TwoSelectArr count];
        }

}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

        if (component == 0) {
            return SCREEN_WIDTH/2;
        }

        if (component == 1) {
            return SCREEN_WIDTH/2;
        }
        
        

 
    return 0;
}


//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

        if (component == 0) {
            
            
            
            return OneArr[row];
        }
        
        if (component == 1) {

            
            return TwoSelectArr[row];
        }
        
  
    return nil;
}
//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 
        if (component == 0) {
            NSString *seletedStr = [OneArr objectAtIndex:row];
            TwoSelectArr = [TwoDic objectForKey:seletedStr];
            
            //重点！更新第二个轮子的数据
            [self.pickView reloadComponent:1];
            
            NSInteger selectedIndex = [self.pickView selectedRowInComponent:1];
            NSString *seletedClass = [TwoSelectArr objectAtIndex:selectedIndex];
            
            self.OneComponentStr = seletedStr;
            
            self.TwoComponentStr = seletedClass;
            
        }
        else {
            NSInteger selectedIndex = [self.pickView selectedRowInComponent:0];
            NSString *seletedStr = [OneArr objectAtIndex:selectedIndex];
            
            NSString *seletedClass = [TwoSelectArr objectAtIndex:row];
            
            
            self.OneComponentStr = seletedStr;
            
            self.TwoComponentStr = seletedClass;
            
            
        }

    
    
    }
//设置列里边组件的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (component == 0) {
        return 40;
    } else {
        return 40;
    }
}

-(UIPickerView *)pickView{

    if (!_pickView) {
        
      _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, Frame.size.width, QDWRealValue(260)-40)];
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
        
        [_CancelButton setTitleColor:_COLOR_RGB(0xe72a2d) forState:UIControlStateNormal];
        

    }

    return _CancelButton;
}
-(UIButton *)SuccessButton{
    if (!_SuccessButton) {
        
        _SuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_SuccessButton setTitle:@"完成" forState:UIControlStateNormal];
        
        _SuccessButton.titleLabel.font = FontSystem(15);
        
        [_SuccessButton setTitleColor:_COLOR_RGB(0xe72a2d) forState:UIControlStateNormal];
        
   
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
