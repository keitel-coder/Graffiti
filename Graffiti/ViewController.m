//
//  ViewController.m
//  Graffiti
//
//  Created by 李贵 on 16/8/22.
//  Copyright © 2016年 李贵. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
#import "UIImage+Extension.h"
#import "MBProgressHUD+Extension.h"

@interface ViewController ()

- (IBAction)back;
- (IBAction)empty;
- (IBAction)save:(id)sender;
/**
 *  绘画视图
 */
@property (weak, nonatomic) IBOutlet PaintView *paintView;

/**
 *  值改变事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)valueChange:(id)sender;
/**
 *  颜色选择视图
 */
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray * subViews = self.colorView.subviews;
    //为UIView添加点击事件
    for (UIView *view in subViews) {
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [view addGestureRecognizer:tapGesture];
    }
//    tapGesture.delegate=self;
//    [self.colorView addGestureRecognizer:tapGesture];
}

-(void)Actiondo:(id)sender{
    UITapGestureRecognizer *tapGesture=sender;
    UIView * view = tapGesture.view;
    self.paintView.color=view.backgroundColor;
    [self.paintView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back {
    [self.paintView back];
}

- (IBAction)empty {
    [self.paintView empty];
}

- (IBAction)save:(id)sender {
    UIImage *image = [UIImage captureWithView:self.paintView];
    // 2.保存到图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 保存图片操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) { // 保存失败
        [MBProgressHUD showError:@"保存失败"];
    } else { // 保存成功
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

- (IBAction)valueChange:(id)sender {
    UISlider *slider = sender;
    self.paintView.lineWidth = slider.value * 20;
    [self.paintView setNeedsDisplay];
}
@end
