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
    
    
    if(self.index == self.question.count) {
        
        NSLog(@"恭喜你! 通关了!");
        
        return;
    }
    
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
        
        [answerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.answerView addSubview:answerButton];
        
    }


}

/** 创建备选按钮 */
- (void)createOptionButtonArea:(Question *) que {

   
    int optionCount = (int) que.options.count;
    
    // 问题：每次调用下一题方法时，都会重新创建21个按钮
    // 解决：如果按钮已经存在，并且是21个，只需要更改按钮标题即可
    if(self.optionView.subviews.count != optionCount) {
    
        for (UIButton *btn in self.optionView.subviews) {
            [btn removeFromSuperview];
        }
        
        
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
            
            // 添加按钮监听方法
            [optionButton addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
    
        }
    
        NSLog(@"创建按钮..");
        
    }
    
    
    // 如果按钮存在, 切换时替换文字
    int i = 0;
    
    for(UIButton *btn in self.optionView.subviews) {
        
        [btn setTitle:que.options[i++] forState:UIControlStateNormal];
        
        //在填好答案会隐藏,将按钮显示出来
        btn.hidden = NO;
    
    }
}


#pragma mark - 候选按钮点击方法


- (void)optionClick:(UIButton *) button {
    
    // 在安全区找到第一个文字为空的按钮
    UIButton *firstBtn = [self firstAnswerButton];
    
    
    // 如果没有找到, 直接返回
    if(firstBtn == nil) {
        return;
    }
    
    // 将选中的文字赋值在答案区
    [firstBtn setTitle:button.currentTitle forState:UIControlStateNormal];
    
    //将选择过得文字隐藏
    button.hidden = YES;
    
    // 比较答案, 判断结果
    [self jude];

}

/**比较结果 */
- (void) jude {

    //如果四个按钮都有文字才判断
    
    BOOL isFull = false;
    
    NSMutableString *mutableStr = [NSMutableString string];
    
    for(UIButton *btn in self.answerView.subviews) {
        
        if(btn.currentTitle.length == 0) {
            isFull = false;
            break;
        } else {
            isFull = true;
            //有字, 拼接字符串
            [mutableStr appendString:btn.currentTitle];
        }
        
    }
    
    
    if(isFull) {
        NSLog(@"字是满的");
        
        //判断答案是否一致
        Question *que = self.question[self.index];
        
        if([mutableStr isEqualToString:que.answer]) {
            NSLog(@"答对啦");
            
            [self setAnwserButtonColor:[UIColor blueColor]];
            
            //延时0.5秒 进入下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
            
        } else {
            NSLog(@"打错了");
            
            [self setAnwserButtonColor:[UIColor redColor]];
        }
    
    }
}

/** 修改答案区按钮的颜色 */
- (void) setAnwserButtonColor:(UIColor *) color {
    for(UIButton *btn in self.answerView.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}


/** 在答案区找到第一个文字为空的按钮*/
- (UIButton *) firstAnswerButton {
  
    for(UIButton *btn in self.answerView.subviews) {
        if(btn.currentTitle.length == 0) {
            return btn;
        }
    }
    
    return nil;
    
}


//控制statusbar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
