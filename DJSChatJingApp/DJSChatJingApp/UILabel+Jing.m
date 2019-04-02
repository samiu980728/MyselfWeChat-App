//
//  UILabel+Jing.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "UILabel+Jing.h"

@implementation UILabel (Jing)

- (CGSize)labelAutoCaculateRectWith:(NSString *)text Font:(UIFont *)textFont MaxSize:(CGSize)masSize
{
    NSDictionary * attributes = @{NSFontAttributeName:textFont};
    CGRect rect = [text boundingRectWithSize:masSize
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
    // 参数1: 自适应尺寸,提供一个宽度,去自适应高度
    // 参数2:自适应设置 (以行为矩形区域自适应,以字体字形自适应)
    // 参数3:文字属性,通常这里面需要知道是字体大小
    // 参数4:绘制文本上下文,做底层排版时使用,填nil即可
}

@end
