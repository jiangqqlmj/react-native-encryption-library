//
//  MD5Tools.m
//  EncryptionDemo
//
//  Created by 江清清 on 16/5/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import "StringEncryption.h"
@implementation Tools

//字符串MD5操作
+(NSString *)MD5:(NSString *)str{
  const char *cStr = [str UTF8String];
  unsigned char result[16];
  CC_MD5( cStr, strlen(cStr), result );
  return [NSString stringWithFormat:
          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
}

//进行字符串的AES加密操作 wIEuw3kAGwVNl7BW
+(NSString *)AESEncryptString:(NSString *)str withKey:(NSString *)encryptKey{
  //开始AES加密
  NSString *result=[StringEncryption encryptString:str withKey:encryptKey];
  return result;
}

+(NSString *)AESDecryptString:(NSString *)str withKey:(NSString *)encryptKey{
  NSString *result=[StringEncryption decryptString:str withKey:encryptKey];
  return result;
}
@end
