//
//  ViewController.m
//  GuessGame
//
//  Created by gyw on 16/9/22.
//  Copyright © 2016年 gyw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)bigImg:(UIButton *)button {
    
    //1.添加蒙版
    UIButton *conver = [[UIButton alloc]initWithFrame:self.view.bounds];
    conver.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:conver];
    conver.alpha = 0.0;
    
    [conver addTarget:self action:@selector(smallImg:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.图片置顶
    [self.view bringSubviewToFront:self.iconButton];
    
    //3.图片变大, 加动画;
    CGFloat width = self.view.bounds.size.width;
    CGFloat y = (self.view.bounds.size.height - width) * 0.5;
    
    
    [UIView animateWithDuration:1.0 animations:^{
        self.iconButton.frame = CGRectMake(0, y, width, width);
        conver.alpha = 1.0;
    }];
}


//图片变小
- (void)smallImg:(UIButton *) conver {

    //1.图片变小
    [UIView animateWithDuration:1.0 animations:^{
        self.iconButton.frame = CGRectMake(96, 90, 128, 128);
        conver.alpha = 0.0;
    } completion:^(BOOL finished) {
        //2.删除蒙版
        [conver removeFromSuperview];
    }];
    
    
    
    
    
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
