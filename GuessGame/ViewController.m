//
//  ViewController.m
//  GuessGame
//
//  Created by gyw on 16/9/22.
//  Copyright © 2016年 gyw. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@property (nonatomic, strong) UIButton *conver;

@property (nonatomic, strong) NSArray *question;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"...%@", self.question);
   
}


//懒加载
- (NSArray *)question {
    
    if(_question == nil) {
        
        _question = [Question questions];
    }
    return _question;
    
}

//使用懒加载
- (UIButton *)conver {
    
    if(_conver == nil) {
    
        _conver = [[UIButton alloc]initWithFrame:self.view.bounds];
        _conver.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self.view addSubview:_conver];
        _conver.alpha = 0.0;
        
        [_conver addTarget:self action:@selector(bigImg) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _conver;
    
}

//控制图片放大缩小
- (IBAction)bigImg {
    
    
    if(self.conver.alpha == 0.0) {
        
        //2.图片置顶
        [self.view bringSubviewToFront:self.iconButton];
        
        //3.图片变大, 加动画;
        CGFloat width = self.view.bounds.size.width;
        CGFloat y = (self.view.bounds.size.height - width) * 0.5;
        
        
        [UIView animateWithDuration:1.0 animations:^{
            self.iconButton.frame = CGRectMake(0, y, width, width);
            self.conver.alpha = 1.0;
        }];

    } else {
        //1.图片变小
        [UIView animateWithDuration:1.0 animations:^{
            self.iconButton.frame = CGRectMake(96, 90, 128, 128);
            self.conver.alpha = 0.0;
        } ];
    }
    
}



//控制statusbar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
