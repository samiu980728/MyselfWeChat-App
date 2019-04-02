//
//  DJSMessageModel.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSMessageModel.h"
#import "ConstantPart.h"
#import "UIImage+Jing.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHight [UIScreen mainScreen].bounds.size.height

@implementation DJSMessageModel

- (CGRect)timeFrame
{
    CGRect rect = CGRectZero;
    if (self.showMessageTime) {
        //都是最长
        CGSize size = [self labelAutoCalculateRectWith:self.messageTime Font:[UIFont fontWithName:FONT_REGULAR size:10] MaxSize:CGSizeMake(MAXFLOAT, 17)];
        rect = CGRectMake((ScreenWidth - size.width) / 2, 0, size.width + 10, 17);
    }
    return rect;
}

- (CGSize)labelAutoCalculateRectWith:(NSString *)text Font:(UIFont *)textFont MaxSize:(CGSize)maxSize
{
    NSDictionary * attributes = @{NSFontAttributeName: textFont};
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size;
}

///头像设置
- (CGRect)logoFrame
{
    CGRect timeRect = [self timeFrame];
    CGRect rect = CGRectZero;
    if (self.messageSenderType == MessageSenderTypeMe) {
        rect = CGRectMake(ScreenWidth - 50, timeRect.size.height + 10, 40, 40);
    } else
    {
        rect = CGRectMake(10, timeRect.size.height + 10, 40, 40);
    }
    return rect;
}

#pragma 这是固定消息栏长度的一个方法
- (CGRect)messageFrame
{
    
    CGRect timeRect = [self timeFrame];
    CGRect rect = CGRectZero;
    CGFloat maxWidth = ScreenWidth * 0.7 - 60;
    CGSize size = [self labelAutoCalculateRectWith:self.messageTextStr Font:[UIFont fontWithName:FONT_REGULAR size:16] MaxSize:CGSizeMake(maxWidth, MAXFLOAT)];
    if (self.messageTextStr == nil) {
        return rect;
    }
    if (self.messageSenderType == MessageSenderTypeMe) {
        //高度最低 44
        rect = CGRectMake(ScreenWidth * 0.3, timeRect.size.height + 10, maxWidth - 5, size.height > 44 ? size.height : 44);
    } else {
        rect = CGRectMake(65, timeRect.size.height + 10, maxWidth, size.height > 44 ? size.height : 44);
    }
    return rect;
}

- (CGRect)voiceFrame
{
    CGRect timeRect = [self timeFrame];
    CGFloat timeLabelHeight = timeRect.size.height;
    CGRect rect = CGRectZero;
    CGFloat maxWidth = ScreenWidth * 0.7 - 60;
    if (self.duringTimeInteger <= 0) {
        return rect;
    }
    if (self.messageSenderType == MessageSenderTypeMe) {
        rect = CGRectMake(AppFrameWidth * 0.3 + 10 + maxWidth - maxWidth *(self.duringTimeInteger/20.0 > 1? 1 :self.duringTimeInteger/20.0), timeLabelHeight + 10, maxWidth *(self.duringTimeInteger/20.0 > 1? 1 :self.duringTimeInteger/20.0), 44);
    } else {
        rect = CGRectMake(50, timeLabelHeight + 10 , maxWidth *(self.duringTimeInteger/20.0 > 1? 1 :self.duringTimeInteger/20.0), 44);
    }
    return rect;
}

- (CGRect)voiceAnimationFrame
{
    //12, 16
    CGRect voiceRect = [self voiceFrame];
    CGRect rect = CGRectZero;
    if (self.messageSenderType == MessageSenderTypeMe)
    {
        rect.origin.x = voiceRect.size.width - 24;
        rect.origin.y = 14;
        rect.size.width = 12;
        rect.size.height = 16;
        
    }
    else
    {
        rect.origin.x = 12;
        rect.origin.y = 14;
        rect.size.width = 12;
        rect.size.height = 16;
    }
    return rect;
}

- (CGRect)imageFrame
{
    CGRect timeRect = [self timeFrame];
    CGFloat timeLabelHeight = timeRect.size.height;
    CGRect rect = CGRectZero;
    
    CGSize imageSize = [self.imageSmallImage imageShowSize];
    
    if (self.imageSmallImage == nil) {
        return rect;
    }
    if (self.messageSenderType == MessageSenderTypeMe) {
        rect = CGRectMake(ScreenWidth - imageSize.width - 50, timeLabelHeight + 10, imageSize.width, imageSize.height);
    } else {
        rect = CGRectMake(50, timeLabelHeight + 10, imageSize.width, imageSize.height);
    }
    return rect;
}

- (CGRect)bubbleFrame
{
    CGRect rect = CGRectZero;
    switch (self.messageType) {
        case MessageTypeText:
            rect = [self messageFrame];
            rect.origin.x = rect.origin.x + (self.messageSenderType == MessageSenderTypeMe? -10 : -15);
            rect.size.width = rect.size.width + 25;
            break;
        case MessageTypeVoice:
            rect = [self voiceFrame];
            break;
        case MessageTypeImage:
            rect = [self imageFrame];
            break;
        default:
            break;
    }
    return rect;
}

- (CGFloat)cellHeight
{
    return [self timeFrame].size.height + [self messageFrame].size.height + [self voiceFrame].size.height + [self imageFrame].size.height + 10;
}

@end
