//
//  MCSelectView.m
//  MCSelectSlider
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 machao. All rights reserved.
//

#import "MCSelectView.h"
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kCount 5
#define kHeigth (kScreenWith - 60)/(kCount - 1)

@interface MCSelectView ()

@property (nonatomic ,strong)NSArray* titleArray;
@property (nonatomic ,assign )NSInteger minSelect;
@property (nonatomic ,assign )NSInteger maxSelect;

@end

@implementation MCSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minSelect = -1;
        self.maxSelect = -1;
        [self setupUI];

    }
    return self;
}
//

-(NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"天使",@"Pre-A",@"A轮",@"B轮",@"B+轮"];
    }
    return _titleArray;
}

-(void)setupUI{
  
    CGFloat selectBtnW = 24;
    CGFloat selectBtnH = 24;
    for (NSInteger i= 0; i< kCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        button.tag = i;
        button.layer.cornerRadius = 12;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, selectBtnW, selectBtnH);
        button.center = CGPointMake(30+i * kHeigth, 34);
        [self addSubview:button];
        UILabel *label = [[UILabel alloc] init];

        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(0, 0, 2*selectBtnW, selectBtnH);
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(30+i * kHeigth, 64);
        label.text = self.titleArray[i];
        [self addSubview:label];
    }
    
}

-(void)drawRect:(CGRect)rect{
    // 画背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(30, 30, kScreenWith - 60, 8)];
    [[UIColor grayColor] set];
    [path fill];
    for (NSInteger i = 0; i < kCount; i++) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(18+i * kHeigth , 22, 24, 24) cornerRadius:12];
        [[UIColor grayColor] set];
        [path fill];
    }
    
    if (self.minSelect != -1 && self.maxSelect != -1) {
        NSInteger minIndex = self.minSelect ;
        NSInteger maxIndex = self.maxSelect ;
        
        // 画圆
        for (NSInteger i = minIndex; i <= maxIndex; i ++) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(13 + i * kHeigth , 17, 34,34 ) cornerRadius:20];
            [[UIColor purpleColor] set];
            [path fill];
            if (i < maxIndex) {
                UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(30 + i * kHeigth, 30, kHeigth, 8)];
                [[UIColor purpleColor] set];
                [rectPath fill];
            }
            
        }
    }
    
}
-(void)buttonClick:(UIButton *)sender{

    if (self.maxSelect == -1 && self.minSelect == -1) {
        self.maxSelect = sender.tag;
        self.minSelect = sender.tag;
        [self setNeedsDisplay];
        if (self.finishBlock) {
            self.finishBlock(self.minSelect,self.maxSelect);
        }
        return;
    }
    if (sender.tag > self.maxSelect) {
        self.maxSelect = sender.tag;
    }else if (sender.tag < self.minSelect){
        self.minSelect = sender.tag;
    }else if (sender.tag == self.maxSelect){
        if (self.maxSelect - 1 >= self.minSelect) {
            self.maxSelect = self.maxSelect - 1;
        }else{
            self.maxSelect = -1;
            self.minSelect = -1;
        }
    }else if (sender.tag == self.minSelect){
        if (self.minSelect+1 <= self.maxSelect) {
            self.minSelect = self.minSelect + 1;
        }else{
            self.maxSelect = -1;
            self.minSelect = -1;
        }
    }
        [self setNeedsDisplay];
    if (self.finishBlock) {
        self.finishBlock(self.minSelect,self.maxSelect);
    }
}
@end
