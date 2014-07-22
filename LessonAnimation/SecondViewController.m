//
//  SecondViewController.m
//  LessonAnimation
//
//  Created by lanou3g on 14-7-14.
//  Copyright (c) 2014年 Winann. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () {
    UIImageView *_imageView;
}

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(45, 30, 230, 230)];
//    view.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:view];
//    [view release];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    _imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageView];
    [_imageView release];
    
//    //masksToBounds 设置为YES，对于layer的subLayers也可以设置成圆角， 设置为NO，只影响本layer，不影响subLayers（只有当subLayers的 大小超出父layer才有效果
//    _imageView.layer.masksToBounds = YES;
//    
//    //设置layer圆角
//    _imageView.layer.cornerRadius = 10;
//    
//    CALayer *layer = [CALayer layer];
//    layer.backgroundColor = [UIColor greenColor].CGColor;
//    layer.frame = CGRectMake(0, 0, 200, 200);
//    [_imageView.layer addSublayer:layer];
    
    _imageView.layer.backgroundColor = [UIColor yellowColor].CGColor;
    
    //设置layer的不透明度，默认为0（透明）
    _imageView.layer.shadowOpacity = 1;
    
    //设置阴影偏移量
    _imageView.layer.shadowOffset = CGSizeMake(20, 20);
    
    //设置阴影颜色
    _imageView.layer.shadowColor = [UIColor redColor].CGColor;
    //阴影的扩散半径
//    _imageView.layer.shadowRadius = 30;
    
//    _imageView.layer.shadowPath
    
    
    
    //锚点默认是视图的中心点（0.5~0.5）,他的取值范围是0.0~1.0;
    NSLog(@"anchorPoint = %@", NSStringFromCGPoint(_imageView.layer.anchorPoint));
//    _imageView.layer.anchorPoint = CGPointMake(0, 0);
    // position 是锚点到父视图原点的距离，
    NSLog(@"position = %@", NSStringFromCGPoint(_imageView.layer.position));
    NSLog(@"%@", NSStringFromCGPoint(_imageView.frame.origin));
    
    

}
- (IBAction)caBasic:(UIButton *)sender {
    
    
    //CABasic 有两个属性 fromValue 动画开始值，toValue动画结束值
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation1 setDuration:2];
    animation1.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    [_imageView.layer addAnimation:animation1 forKey:@"position"];
    
    //设置背景
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation2.duration = 1.0f;
    animation2.fromValue = (id)[UIColor redColor].CGColor;
    animation2.toValue = (id)[UIColor purpleColor].CGColor;
    [_imageView.layer addAnimation:animation2 forKey:@"背景颜色"];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.fromValue = @1.0;
    animation.toValue = @1.5;
    [animation setDuration:2];
    [_imageView.layer addAnimation:animation forKey:@"scale"];
    
}
- (IBAction)caKeyFrome:(UIButton *)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //多帧
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 150)],
                         [NSValue valueWithCGPoint:CGPointMake(100, 200)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 250)]];
    [animation setDuration:4];
    [_imageView.layer addAnimation:animation forKey:@"positions"];
    
}
- (IBAction)caGroup:(UIButton *)sender {
    
    //创建组动画对象
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    //CABasic动画
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation1.fromValue = @1.5;
    animation1.toValue = @0.5;
    
    //关键帧动画
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.values = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 150)],
                         [NSValue valueWithCGPoint:CGPointMake(100, 200)],
                         [NSValue valueWithCGPoint:CGPointMake(200, 250)]];
    
    //group添加动画数组，group中动画对象并发执行
    [group setAnimations:@[animation1, animation2]];
    [group setDuration:4.0f];
    [_imageView.layer addAnimation:group forKey:@"group"];
    
}
- (IBAction)cakeyFrome_path:(UIButton *)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4;
    //create后要release
    CGMutablePathRef path = CGPathCreateMutable();
    //path起始位置
    CGPathMoveToPoint(path, NULL, 100, 100);
    //path经过的点
    CGPathAddLineToPoint(path, NULL, 200, 150);
    CGPathAddLineToPoint(path, NULL, 100, 200);
    CGPathAddLineToPoint(path, NULL, 200, 250);
    
    //将创建的path对象，赋值给animation.path
    animation.path = path;
    
    //释放path对象
    CGPathRelease(path);
    [_imageView.layer addAnimation:animation forKey:@"positions"];
    
}
- (IBAction)caTransition:(UIButton *)sender {
    
    CATransition *animation = [CATransition animation];
    //动画过渡效果
//    animation.type = kCATransitionReveal;
    animation.type = @"suckEffect";
    
    //动画过渡方向
    animation.subtype = kCATransitionFromTop;
    [animation setDuration:1.5];
    [_imageView.layer addAnimation:animation forKey:@"transition"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
