//
//  MCSelectView.h
//  MCSelectSlider
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 machao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MCRequestCallBack)(NSInteger min, NSInteger max);

@interface MCSelectView : UIView

@property (nonatomic ,copy)MCRequestCallBack finishBlock;
@end
