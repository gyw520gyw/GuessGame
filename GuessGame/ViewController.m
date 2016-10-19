//
//  ViewController.m
//  GuessGame
//
//  Created by gyw on 16/9/22.
//  Copyright © 2016年 gyw. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

#define buttonWidth 35
#define buttonHeigth 35
#define buttonMargin 10

#define optionColCount 7    //操作区 列数


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *questionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIView *answerView;

@property (weak, nonatomic) IBOutlet UIView *optionView;


//遮罩
@property (nonatomic, strong) UIButton *conver;

@property (nonatomic, strong) NSArray *question;

//索引
@property (nonatomic, assign) int index;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"...%@", self.question);
    
    self.index = -1;
    
    [self nextQuestion];
   
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

#pragma mark ----- 大小图切换
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
            self.iconButton.frame = CGRectMake(96, 128, 128, 128);
            self.conver.alpha = 0.0;
        } ];
    }
    
}



#pragma mark ----- 下一题
- (IBAction)nextQuestion {
    
    //利用索引从数组取数据
    self.index ++;
    
    //从数组中按照索引取出题目模型数据
    Question *que = self.question[self.index];


    //设置基本信息
    [self setupBasicInfo:que];
    
    // 答案区
    [self createAnswerButtonArea:que];
    
    
    // 选项区
    [self createOptionButtonArea:que];
    
}

/** 设置基本信息 */
- (void)setupBasicInfo:(Question *) que {
    
    //防止数组越界
    self.nextButton.enabled = (self.index < self.question.count - 1 );
    
    
    
    self.questionNumLabel.text = [NSString stringWithFormat:@"%d/%d", self.index+1, (int)self.question.count];
    
    self.questionTitleLabel.text = que.title;
    
    [self.iconButton setImage:[UIImage imageNamed:que.icon] forState:UIControlStateNormal];

}


/** 创建答案区按钮 */
- (void)createAnswerButtonArea:(Question *) que {
    
    for (UIButton *btn in self.answerView.subviews) {
        [btn removeFromSuperview];
    }
    
    int answerCount = (int)que.answer.length;
    
    CGFloat startX = (self.answerView.bounds.size.width - (buttonWidth * answerCount) - (buttonMargin * (answerCount-1))) * 0.5;
    
    for(int i = 0; i < answerCount; i++) {
        
        CGFloat buttonStartX = startX + (buttonWidth + buttonMargin) * i;
        
        UIButton *answerButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonStartX, 0, buttonWidth, buttonHeigth)];
        
        [answerButton setBackgroundImage:[UIImage imageNamed:@"btn_answer"]forState:UIControlStateNormal];
        [answerButton setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        
        [self.answerView addSubview:answerButton];
        
    }


}

/** 创建备选按钮 */
- (void)createOptionButtonArea:(Question *) que {

    for (UIButton *btn in self.optionView.subviews) {
        [btn removeFromSuperview];
    }
    
    
    
    int optionCount = (int) que.options.count;
    
    CGFloat optionStartX = (self.answerView.bounds.size.width - (buttonWidth * optionColCount) - (buttonMargin * (optionColCount-1))) * 0.5;
    
    for(int i = 0; i < optionCount; i ++) {
        
        
        CGFloat row = i / optionColCount;
        CGFloat col = i % optionColCount;
        
        CGFloat buttonStartX = optionStartX + (buttonMargin + buttonWidth) * col;
        CGFloat buttonStartY = (buttonMargin + buttonWidth) * row;
        
        UIButton *optionButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonStartX, buttonStartY, buttonWidth, buttonHeigth)];
        
        
        [optionButton setBackgroundImage:[UIImage imageNamed:@"btn_option"]forState:UIControlStateNormal];
        [optionButton setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        //设置字体颜色
        [optionButton setTitle:que.options[i] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         
         
        [self.optionView addSubview:optionButton];
        
        
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
