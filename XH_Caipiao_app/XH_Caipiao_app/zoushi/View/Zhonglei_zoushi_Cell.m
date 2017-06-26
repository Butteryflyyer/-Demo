//
//  Zhonglei_zoushi_Cell.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/26.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "Zhonglei_zoushi_Cell.h"

@implementation Zhonglei_zoushi_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(Caipiao_Model *)model{
    _model = model;
    
    NSMutableArray *arr = [self getcodeArr];
    for (NSInteger i = 0; i < arr.count; i++) {
        UILabel *label = [QDWTools initLabelWithText:arr[i] WithTextColor:_COLOR_RGB(0xffffff) Withfont:10 WithFrame:CGRectMake(10+10+(10+22)*i, 10, 22, 30) WithTextAlit:NSTextAlignmentCenter];
        label.centerY = self.frame.size.height/2;
        label.backgroundColor = [UIColor redColor];
        
        [self addSubview:label];
    }
    
    
    
}
-(NSMutableArray *)getcodeArr{
    NSArray *arr = [QDWTools GetArrDeletedouhaoWithStr:self.model.openCode];
    NSMutableArray *muarr = [[NSMutableArray alloc]init];
    for (NSInteger i =0; i< arr.count; i++) {
        NSString *str = arr[i];
        if (str.length > 4) {
            NSArray *addCompare  = [str componentsSeparatedByString:@"+"];
            for (NSString *mstr in addCompare) {
                [muarr addObject:mstr];
            }
        }else{
            [muarr addObject:str];
        }
        
    }
    return muarr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
