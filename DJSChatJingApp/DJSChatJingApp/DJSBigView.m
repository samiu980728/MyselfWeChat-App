//
//  DJSBigView.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/2.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSBigView.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHight [UIScreen mainScreen].bounds.size.height

@implementation DJSBigView

- (instancetype)init
{
    if (self = [super init]) {
        [self creatImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatImageView];
    }
    return self;
}

- (void)creatImageView
{
    self.backgroundColor = [UIColor blackColor];
    if (self.bigImageView == nil) {
        self.bigImageView = [[UIImageView alloc] init];
        self.bigImageView.bounds = CGRectMake(0, 0, 10, 10);
        [self addSubview:self.bigImageView];
    }
    //添加手势 点击后 图片缩小
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [self addGestureRecognizer:tap];
}

- (void)tapClicked:(UITapGestureRecognizer *)sender
{
    //移除视图
    [self removeFromSuperview];
}

- (void)setShow:(BOOL)show
{
    _show = show;
    if (show) {
        CGSize size = _bigImageView.image.size;
        CGFloat bigHeight = size.height;
        CGFloat bigWidth = size.width;
        if (bigWidth >= ScreenWidth) {
            if (bigHeight / bigWidth <= ScreenHight / ScreenWidth) {
                bigHeight = bigHeight / bigWidth * ScreenWidth;
                bigWidth = ScreenWidth;
            } else {
                bigWidth = bigWidth / bigHeight * ScreenHight;
                bigHeight = ScreenHight;
            }
        }
        _bigImageView.center = self.center;
        _bigImageView.bounds = CGRectMake(0, 0, bigWidth, bigHeight);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
