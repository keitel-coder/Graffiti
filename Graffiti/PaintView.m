//
//  PaintView.m
//  Graffiti
//
//  Created by 李贵 on 16/8/23.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "PaintView.h"

@interface PaintView()

/**
 *  保存路径
 */
@property(strong,nonatomic) NSMutableArray *paths;

@end

@implementation PaintView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(NSMutableArray*)paths{
    if(_paths==nil){
        _paths=[NSMutableArray array];
    }
    return _paths;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 1.获得当前的触摸点
    UITouch *touch = [touches anyObject];
    CGPoint startPos = [touch locationInView:touch.view];
    
    // 2.创建一个新的路径
    UIBezierPath *currenPath = [UIBezierPath bezierPath];
    currenPath.lineCapStyle = kCGLineCapRound;
    currenPath.lineJoinStyle = kCGLineJoinRound;
    [currenPath moveToPoint:startPos];
    [self.paths addObject:currenPath];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point=[touch locationInView:touch.view];
    UIBezierPath *path = [self.paths lastObject];
    [path addLineToPoint:point];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect
{
    [self.color set];
//    [[UIColor redColor] set];
    for (UIBezierPath *path in self.paths) {
        path.lineWidth = self.lineWidth<1?1:self.lineWidth;
        [path stroke];
    }
}

-(void)back{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

-(void)empty{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)testPath
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextMoveToPoint(ctx, 0, 0);
    //    CGContextAddLineToPoint(ctx, 100, 100);
    //    CGContextStrokePath(ctx);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    CGContextAddPath(ctx, path);
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, 250, 250);
    CGPathAddLineToPoint(path2, NULL, 110, 100);
    CGContextAddPath(ctx, path2);
    
    CGContextStrokePath(ctx);
    
    CGPathRelease(path);
}
@end
