//
//  DJSRecord.h
//  DJSChatJingApp
//
//  Created by 萨缪 on 2019/4/2.
//  Copyright © 2019年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJSRecord : NSObject
+ (instancetype)ShareCSRecord;
- (void)beginRecord;
- (void)endRecord;
//- (void)getVoicePath;
//- (void)getVoiceFile;
- (void)playRecord;
@end
