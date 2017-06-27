//
//  CityCustomcell.h
//  JiuYouApp
//
//  Created by draway on 16/1/12.
//  Copyright © 2016年 XH.draway.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityCustomcelldelegate <NSObject>

-(void)Transationwords:(NSString *)word;

@end
/**
 *  城市自定义cell
 */
@interface CityCustomcell : UITableViewCell

@property(nonatomic,weak)id<CityCustomcelldelegate>delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier With:(CGRect)frame WithifSearchOrSelected:(NSString *)IfSearchOrSelected;
-(void)createViews;
@end
