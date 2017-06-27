//
//  CityCustomcell.m
//  JiuYouApp
//
//  Created by draway on 16/1/12.
//  Copyright © 2016年 XH.draway.com. All rights reserved.
//

#import "CityCustomcell.h"

@interface CityCustomcell ()
{
    
    NSArray *_dataSource;
    
}
@end

@implementation CityCustomcell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier With:(CGRect)frame WithifSearchOrSelected:(NSString *)IfSearchOrSelected{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        if ([IfSearchOrSelected isEqual:@"搜索"]) {
            _dataSource = [[NSMutableArray alloc]initWithObjects:@"全部城市",@"北京",@"上海",@"成都",@"重庆",@"大连",@"广州",@"哈尔滨",@"杭州",@"济南",@"南京",@"青岛",@"深圳",@"沈阳",@"天津",@"武汉",@"西安", nil];
        }
        if (IfSearchOrSelected == nil) {
            _dataSource = [[NSMutableArray alloc]initWithObjects:@"北京",@"上海",@"成都",@"重庆",@"大连",@"广州",@"哈尔滨",@"杭州",@"济南",@"南京",@"青岛",@"深圳",@"沈阳",@"天津",@"武汉",@"西安", nil];
        }
        
        //        cellFrame = frame;
        
        
    }
    return self;
    
    
    
}


-(void)createViews{
    
    self.backgroundColor = _COLOR_RGB(0xFFFFFF);
    
    
    
    CGFloat width ;
    CGFloat hight ;
    
    if (SCREEN_WIDTH > 320) {
        
        width = 95;
        hight = 40;
        
    }else{
        
        width = 80 ;
        hight = 30 ;
        
    }
    
    
    
    
    for (NSInteger i =0; i < _dataSource.count; i++) {
        
        
        
        //        _imageview.tag = i+1;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((i%3)*(width+10)+20,(i/3)*(10+hight)+2.5 , width, hight)];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = _COLOR_RGB(0xdcdcdc).CGColor;
        btn.layer.cornerRadius = 5;
        
        [btn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:_dataSource[i] forState:UIControlStateNormal];
        
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = _COLOR_RGB(0xcccccc).CGColor;
        
        btn.titleLabel.font = FontSystem(15);
        [btn setTitleColor:_COLOR_RGB(0x666666) forState:UIControlStateNormal];
        
        
        
        [self.contentView addSubview:btn];
        
    }
    
    
    
    
}

-(void)btnaction:(UIButton *)btn{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(Transationwords:)]) {
        
        [self.delegate Transationwords:btn.titleLabel.text];
    }
    
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
