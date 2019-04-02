//
//  DJSEmojiView.h
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJSEmojiCollectionViewCell.h"

@protocol emojiViewDelegate <NSObject>

- (void)emojiClicked:(NSString *)emojiStr;

@end

@interface DJSEmojiView : UIView

@property (nonatomic, strong) id <emojiViewDelegate> delegate;

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, copy) NSArray * dataArray;

@end
