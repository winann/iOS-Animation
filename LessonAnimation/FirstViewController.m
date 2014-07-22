//
//  FirstViewController.m
//  LessonAnimation
//
//  Created by lanou3g on 14-7-14.
//  Copyright (c) 2014年 Winann. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () {
    UIImageView *_showImageView;
    UIView *_fromView;
    UIView *_toView;
}

@end

@implementation FirstViewController

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
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    _showImageView.backgroundColor = [UIColor redColor];
    _showImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"夕阳" ofType:@"jpg"]];
    [self.view addSubview:_showImageView];
    [_showImageView release];
    
    
    _fromView = [[UIView alloc] initWithFrame:_showImageView.bounds];
    _fromView.backgroundColor = [UIColor redColor];
    [_showImageView addSubview:_fromView];
    
    
    _toView = [[UIView alloc] initWithFrame:_showImageView.bounds];
    _toView.backgroundColor = [UIColor blackColor];

    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(45, 30, 230, 230)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    [view release];
}

- (IBAction)uiviewAttribute:(UIButton *)sender {
    NSLog(@"Attribut");
    
    //UIView 使用Context实现动画
    
    //参数1 动画名称 参数2 要实现动画的对象上下文
    
    [UIView beginAnimations:@"attribute" context:_showImageView];
    
    //设置动画的时间
    [UIView setAnimationDuration:1.0f];
    
    //设置动画延迟时间
//    [UIView setAnimationDelay:2];
    
    //设置视图center 实现试图移动动画
    _showImageView.center = CGPointMake(100, 100);
    
    //设置alpha值:视图透明度
    _showImageView.alpha = 0.2f;
    
    //设置背景颜色
    _showImageView.backgroundColor = [UIColor greenColor];
    
    //UIView动画 设置代理
    [UIView setAnimationDelegate:self];
    
    //动画将要开始代理方法
    [UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];
    
    //动画已经结束代理方法
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    //提交动画设置，执行动画
    [UIView commitAnimations];
    
    
}
- (IBAction)translation:(UIButton *)sender {
    
    //UIView动画， 使用Block实现
    [UIView animateWithDuration:1.0f animations:^{
        
        //通过设置translation 实现视图的偏移
        if ([self.mySwitch isOn]) {
            
            //基于上一次的translation
            _showImageView.transform = CGAffineTransformTranslate(_showImageView.transform, 50, 0);
        } else {
            
            //基于原始的translation
            _showImageView.transform = CGAffineTransformMakeTranslation(-50, 0);
        }
    }];
}
- (IBAction)rotation:(UIButton *)sender {
    
    [UIView animateWithDuration:1.0f animations:^{
        if ([self.mySwitch isOn]) {
            _showImageView.transform = CGAffineTransformRotate(_showImageView.transform, M_PI);
        } else {
            _showImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
        
        //动画完成之后还可以再嵌套动画
        [UIView animateWithDuration:1.0f animations:^{
            _showImageView.transform = CGAffineTransformRotate(_showImageView.transform, -M_PI_2);
        }];
    }];
}
- (IBAction)scale:(UIButton *)sender {
    
    
    //UIViewAnimationOptionAutoreverse 自动换向
    //UIViewAnimationOptionRepeat 重复
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionRepeat animations:^{
        if ([self.mySwitch isOn]) {
            
            //基于上一次
            _showImageView.transform = CGAffineTransformScale(_showImageView.transform, 1.2, 1.2);
        } else {
            
            //基于原始
            _showImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
    
}

//过渡效果
- (IBAction)transition:(UIButton *)sender {
    
//    UIViewAnimationOptionTransitionFlipFromBottom 过度效果
//    UIViewAnimationOptionTransitionNone
//    UIViewAnimationOptionTransitionFlipFromLeft
//    UIViewAnimationOptionTransitionFlipFromRight
//    UIViewAnimationOptionTransitionCurlUp
//    UIViewAnimationOptionTransitionCurlDown
//    UIViewAnimationOptionTransitionCrossDissolve
//    UIViewAnimationOptionTransitionFlipFromTop
//    UIViewAnimationOptionTransitionFlipFromBottom
    [UIView transitionWithView:_showImageView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        
        if (_fromView.superview != nil) {
            [_fromView removeFromSuperview];
            [_showImageView addSubview:_toView];
        } else {
            [_toView removeFromSuperview];
            [_showImageView addSubview:_fromView];
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}

//动画将要开始
- (void)animationWillStart:(NSString *)animationID context:(void *)context {
    NSLog(@"动画将要开始");
    NSLog(@"%s, %d animationID = %@", __FUNCTION__, __LINE__, animationID);
}

//动画已经结束
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    NSLog(@"%s, %d", __FUNCTION__, __LINE__);
    
    //动画完成之后，showImageView回到初始位置
    _showImageView.center = CGPointMake(150, 150);
    _showImageView.alpha = 1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [_mySwitch release];
    [_showImageView release];
    [_fromView release], _fromView = nil;
    [_toView release], _toView = nil;
    [super dealloc];
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
