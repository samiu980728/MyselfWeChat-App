//
//  DJSEmojiView.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "DJSEmojiView.h"
#import "DJSEmojiCollectionViewCell.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHight [UIScreen mainScreen].bounds.size.height


@interface DJSEmojiView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{

}

@end

@implementation DJSEmojiView

- (instancetype)init
{
    if ([super init]) {
        [self creatEmojiView];
    }
    return self;
}

- (void)creatEmojiView
{
    NSString * emojiPath = [[NSBundle mainBundle] pathForResource:@"emojiList" ofType:@"plist"];
    self.dataArray = [NSArray arrayWithContentsOfFile:emojiPath];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //横向滑动
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(ScreenWidth/8, ScreenHight/3);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[DJSEmojiCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//每一个cell是什么
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DJSEmojiCollectionViewCell * cell = (DJSEmojiCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.emojiLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiClicked:)]) {
        NSString * emojiStr = self.dataArray[indexPath.row];
        [self.delegate emojiClicked:emojiStr];
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
