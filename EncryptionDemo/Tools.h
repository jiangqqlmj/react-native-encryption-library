//
//  MD5Tools.h
//  EncryptionDemo
//
//  Created by 江清清 on 16/5/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
//进行字符串的MD5操作
+(NSString *)MD5:(NSString *)str;
+(NSString *)AESEncryptString:(NSString *)str withKey:(NSString *)encryptKey;
+(NSString *)AESDecryptString:(NSString *)str withKey:(NSString *)encryptKey;
@end

