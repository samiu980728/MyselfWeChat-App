//
//  DJSEmojiCollectionViewCell.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSEmojiCollectionViewCell.h"

@implementation DJSEmojiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.emojiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.emojiLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.emojiLabel];
    }
    return self;
}

@end
