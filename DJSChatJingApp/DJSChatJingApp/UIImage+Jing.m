//
//  UIImage+Jing.m
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/1.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import "UIImage+Jing.h"
#define MAX_IMAGE_W 141.0
#define MAX_IMAGE_H 228.0
@implementation UIImage (Jing)

///判断图片的长度和宽度
- (CGSize)imageShowSize
{
    CGFloat imagwWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    
    //宽度大于高度
    if (imagwWidth > imageHeight) {
        ///情况1 宽度超过标准宽度
        if (imagwWidth > MAX_IMAGE_W) {
            ///按比例缩放：imageHeight * MAX_IMAGE_W / imagwWidth
            return CGSizeMake(MAX_IMAGE_W, imageHeight * MAX_IMAGE_W / imagwWidth);
        } else {
            return self.size;
        }
    } else {
        if (imageHeight > MAX_IMAGE_H) {
            return CGSizeMake(imagwWidth * MAX_IMAGE_W / imageHeight, MAX_IMAGE_W);
        } else {
            return self.size;
        }
    }
}

@end
