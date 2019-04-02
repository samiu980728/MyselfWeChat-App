//
//  DJSMessageTableViewCell.h
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJSMessageTableViewCell;
@protocol DJSMessageTableViewCellDelegate <NSObject>

- (void)messageCellSingleClickedWith:(DJSMessageTableViewCell *)cell;

@end

@class DJSMessageModel;

@interface DJSMessageTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView messageModel:(DJSMessageModel *)model;

@property (nonatomic, strong) UIImageView * voiceAnimationImageView;

@property (nonatomic, strong) UIImageView * imageImageView;

@property (nonatomic, strong) DJSMessageModel * messageModel;

@property (nonatomic, weak) id <DJSMessageTableViewCellDelegate> delegate;

-(void)stopVoiceAnimation;

-(void)startVoiceAnimation;

@end
