//
//  DJSMessageTableViewCell.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSMessageTableViewCell.h"
#import "DJSMessageModel.h"
#import "ConstantPart.h"
#import "UILabel+Jing.h"
#import "UIImage+Jing.h"

@interface DJSMessageTableViewCell()

@property (nonatomic, strong) UIImageView * logoImageView;

@property (nonatomic, strong) UIImageView * bubbleImageView;

@property (nonatomic, strong) UIImageView * voiceImageView;

@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UIFont * textFont;

@end

@implementation DJSMessageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView messageModel:(DJSMessageModel *)model
{
    static NSString * identifier = @"WeChatCell";
    DJSMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DJSMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.messageModel = model;
    return cell;
}

//在这里面添加视图中所有的基本控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self creatSubViewTime];
    [self creatSubViewBubble];
    [self creatSubViewLogo];
    [self creatSubViewMessage];
    [self creatSubViewVoice];
    [self creatSubViewAnimationVoice];
    [self creatSubViewImage];
    }
    return self;
}

#pragma mark - 创建子视图
- (void)creatSubViewMessage
{
    //这里先把所有的 语音 图片 和 文本聊天控件设置为默认隐藏 如果需要用到的时候再进行激活
    self.messageLabel= [[UILabel alloc] init];
    self.messageLabel.hidden = YES;
    [self.contentView addSubview:self.messageLabel];
    self.textFont = [UIFont fontWithName:FONT_REGULAR size:16];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageLabel.font = self.textFont;
    self.messageLabel.textColor=COLOR_444444;
}

- (void)creatSubViewTime
{
    //配置标签信息 但不能先赋值文本
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.hidden = YES;
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.font = [UIFont fontWithName:FONT_REGULAR size:10];
    self.timeLabel.backgroundColor = COLOR_cecece;
    self.timeLabel.textColor = COLOR_ffffff;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.layer.cornerRadius = 4;
    self.timeLabel.layer.borderColor = [COLOR_cecece CGColor];
    self.timeLabel.layer.borderWidth = 1;
}

- (void)creatSubViewLogo
{
    //👤
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.hidden = YES;
//    self.logoImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.logoImageView];
}
- (void)creatSubViewBubble
{
    //图片视图的添加 长按手势的处理
    //聊天框气泡
    self.bubbleImageView = [[UIImageView alloc] init];
    self.bubbleImageView.hidden = YES;
    self.bubbleImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.bubbleImageView];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBubbleView:)];
    [self.bubbleImageView addGestureRecognizer:longPressGesture];
    
    UITapGestureRecognizer * singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap2:)];
    [self.bubbleImageView addGestureRecognizer:singleTap2];
}

- (void)creatSubViewVoice
{
    _voiceImageView   = [[UIImageView alloc] init];
    _voiceImageView.hidden   = YES;
    [self.contentView addSubview:_voiceImageView];
}

- (void)creatSubViewAnimationVoice
{
    _voiceAnimationImageView   = [[UIImageView alloc] init];
    _voiceAnimationImageView.hidden   = YES;
    [_voiceImageView addSubview:_voiceAnimationImageView];
}

- (void)creatSubViewImage
{
    _imageImageView  = [[UIImageView alloc] init];
    _imageImageView.hidden   = YES;
    [self.contentView addSubview:_imageImageView];
}

- (void)setMessageModel:(DJSMessageModel *)messageModel
{
    self.messageModel = messageModel;
    self.timeLabel.hidden = !messageModel.showMessageTime;
    self.timeLabel.frame = [messageModel timeFrame];
    self.timeLabel.text = messageModel.messageTime;

    self.logoImageView.hidden = NO;
    self.logoImageView.frame = [messageModel logoFrame];
    
    self.bubbleImageView.hidden = NO;
    self.bubbleImageView.frame = [messageModel bubbleFrame];
    
    if (messageModel.messageSenderType == MessageSenderTypeMe) {
        self.logoImageView.image = [UIImage imageNamed:@"w"];
        //聊天框气泡的拉伸
        self.bubbleImageView.image = [[UIImage imageNamed:@"me"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
    } else {
        self.logoImageView.image = [UIImage imageNamed:@"m"];
        self.bubbleImageView.image = [[UIImage imageNamed:@"other"] stretchableImageWithLeftCapWidth:20 topCapHeight:40];
    }
    switch (messageModel.messageType) {
        case MessageTypeText:
            self.messageLabel.hidden = NO;
            self.messageLabel.frame = [messageModel messageFrame];
            self.messageLabel.text = messageModel.messageTextStr;
#pragma mark Request: 如果在这里想要修改气泡的长度 就需要 在这里根据发送者的不同来规定文本是靠左还是靠右
            self.messageLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case MessageTypeVoice:
            //这里是语音设置 暂时不写
            _voiceImageView.hidden = NO;
            _voiceImageView.frame = [messageModel voiceFrame];
            _messageLabel.hidden = NO;
            _messageLabel.frame = [messageModel voiceFrame];
            _messageLabel.textAlignment = messageModel.messageSenderType == MessageSenderTypeMe ? NSTextAlignmentLeft:NSTextAlignmentRight;
            _messageLabel.text = [NSString stringWithFormat:@"%ld''",(long)messageModel.duringTimeInteger];
            _voiceAnimationImageView.hidden = NO;
            _voiceAnimationImageView.frame = [messageModel voiceAnimationFrame];
            _voiceAnimationImageView.image=[UIImage imageNamed:@"wechatvoice3"];
            _voiceAnimationImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"wechatvoice3"],[UIImage imageNamed:@"wechatvoice3_1"],[UIImage imageNamed:@"wechatvoice3_0"],[UIImage imageNamed:@"wechatvoice3_1"],[UIImage imageNamed:@"wechatvoice3"],nil];
            
            _voiceAnimationImageView.animationDuration = 1;
            _voiceAnimationImageView.transform = messageModel.messageSenderType == MessageSenderTypeMe ?  CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
            _voiceAnimationImageView.animationRepeatCount = -1;
            break;
        case MessageTypeImage:
#pragma mark Request 这里是照片设置
            self.imageImageView.hidden = NO;
            self.imageImageView.frame = [messageModel imageFrame];
            self.imageImageView.image = messageModel.imageSmallImage;
            CGSize imageSize = [messageModel.imageSmallImage imageShowSize];
            UIImageView * imageViewMask = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:messageModel.messageSenderType == MessageSenderTypeMe ? @"me" : @"other"] stretchableImageWithLeftCapWidth:20 topCapHeight:40]];
            imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
            self.imageImageView.layer.mask = imageViewMask.layer;
            break;
//        default:
//            break;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.frame = CGRectMake(0, 0, AppFrameWidth, 44);
    _logoImageView.hidden = YES;
    _bubbleImageView.hidden = YES;
    _voiceImageView.hidden = YES;
    _messageLabel.hidden = YES;
    _timeLabel.hidden = YES;
    _imageImageView.hidden = YES;
}

#pragma 长按事件
- (void)longPressBubbleView:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self showMenuControllerInView:self bgView:sender.view];
    }
}

- (void)showMenuControllerInView:(DJSMessageTableViewCell *)inView
                          bgView:(UIView *)supView
{
    //变成第一响应者
    [self becomeFirstResponder];
    DJSMessageModel * messageModel = self.messageModel;
    UIMenuItem * copyTextItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextSender1:)];
    UIMenuItem * copyTextItem2 = [[UIMenuItem alloc] initWithTitle:@"保存到相册" action:@selector(copyTextSender2:)];
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:supView.frame inView:inView];
    [menu setArrowDirection:UIMenuControllerArrowDefault];
    if (messageModel.messageType == MessageTypeText) {
        [menu setMenuItems:@[copyTextItem1]];
    } else if (messageModel.messageType == MessageTypeImage) {
        [menu setMenuItems:@[copyTextItem2]];
    } else if (messageModel.messageType == MessageTypeVoice) {
        
    }
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark 剪切板代理方法
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 通过这个方法告诉UIMenuController它内部应该显示什么内容
 * 返回YES，就代表支持action这个操作
 */
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copyTextSender1:)) {
        return true;
    } else if (action == @selector(copyTextSender2:)) {
        return true;
    } else {
        return false;
    }
}

-(void)copyTextSender1:(id)sender
{
    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
    if (self.messageModel.messageTextStr.length > 0) {
        pasteBoard.string = self.messageModel.messageTextStr;
    }
}

-(void)copyTextSender2:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.imageImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//图片视图的添加 复制的方法
-(void)handleSingleTap2:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellSingleClickedWith:)]) {
        [self.delegate messageCellSingleClickedWith:self];
    }
}

//开始录音动画
- (void)startVoiceAnimation
{
    [self.voiceAnimationImageView startAnimating];
}

//结束录音动画
- (void)stopVoiceAnimation
{
    [self.voiceAnimationImageView stopAnimating];
}

//保存到相册回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
