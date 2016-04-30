//
//  ViewController.m
//  MCSelectSlider
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 machao. All rights reserved.
//

#import "ViewController.h"
#import "MCSelectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MCSelectView *selectView =[[MCSelectView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 80)];
    selectView.backgroundColor = [UIColor orangeColor];
    selectView.finishBlock = ^(NSInteger min, NSInteger max){
        NSLog(@"%ld---%ld",min,max);
    };
    [self.view addSubview:selectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
