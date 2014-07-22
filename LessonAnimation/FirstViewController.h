//
//  FirstViewController.h
//  LessonAnimation
//
//  Created by lanou3g on 14-7-14.
//  Copyright (c) 2014年 Winann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (retain, nonatomic) IBOutlet UISwitch *mySwitch;

- (IBAction)uiviewAttribute:(UIButton *)sender;
- (IBAction)translation:(UIButton *)sender;
- (IBAction)rotation:(UIButton *)sender;
- (IBAction)scale:(UIButton *)sender;
- (IBAction)transition:(UIButton *)sender;


@end
