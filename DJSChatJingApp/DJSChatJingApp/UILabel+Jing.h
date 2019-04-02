//
//  UILabel+Jing.h
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Jing)

- (CGSize)labelAutoCaculateRectWith:(NSString *)text Font:(UIFont *)textFont MaxSize:(CGSize)masSize;

@end
