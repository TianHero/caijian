//
//  ViewController.m
//  圆环
//
//  Created by 赵天 on 16/6/26.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.imageView];
    
    [self yuan];
    
}
/**
 *  在圆形外面加一个圆环
 */
- (void)yuanHuan{
    //0.加载图片
    UIImage *image = [UIImage imageNamed:@"AppIcon1024"];
    //图片的宽度
    CGFloat imageWH = image.size.width;
    //设置圆环的宽度
    CGFloat border = 1;
    //大圆形的宽度高度
    CGFloat ovalWH = imageWH + 2 * border;
    
    //1、开启位图上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    //2、画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [[UIColor redColor] set];
    [path fill];
    
    //3、设置裁剪区（小圆）
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    [clipPath addClip];
    
    //4、绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    
    //5、获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //6、关闭上下文
    UIGraphicsEndImageContext();
    
    
    self.imageView.image = clipImage;
}
/**
 *  裁剪一个原型图片
 */
- (void)yuan{
    //获取图片
    UIImage *image = [UIImage imageNamed:@"AppIcon1024"];
    //1.开启位图上下文，跟图片尺寸大小一样
    //NO:不透明  0：scale不缩放
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.设置图形裁剪区域，正切图片
    //2.1创建一个圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.width)];
    //2.2把路径设置裁剪区
    [path addClip];
    //3.绘制图片
    [image drawAtPoint:CGPointMake(0, 0)];
    //4.从上下文中获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    
    _imageView.image = clipImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
