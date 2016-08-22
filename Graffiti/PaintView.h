//
//  PaintView.h
//  Graffiti
//
//  Created by 李贵 on 16/8/23.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintView : UIView

/**
 *  线宽度
 */
@property(assign,nonatomic)NSInteger lineWidth;

/**
 *  颜色
 */
@property(strong,nonatomic) UIColor *color;

-(void)back;
-(void)empty;
@end
