//
//  EncryptionLibrary.m
//  EncryptionDemo
//
//  Created by 江清清 on 16/5/27.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "EncryptionLibrary.h"
#import "Tools.h"

@implementation EncryptionLibrary 


RCT_EXPORT_MODULE(EncryptionModule)


RCT_EXPORT_METHOD(MD5ByCallBack:(NSString *)message callback:(RCTResponseSenderBlock)callback){
   NSLog(@"传入的待加密数据为:%@",message);
   NSString *result=[Tools MD5:message];
   callback(@[[NSNull null],result]);
}

RCT_EXPORT_METHOD(MD5ByPromise:(NSString*)message
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
  NSString *result=[Tools MD5:message];
  if(![result isEqualToString:@""]){
     resolve(result);
  }else{
    NSError *error=[NSError errorWithDomain:@"我是Promise回调错误信息..." code:500 userInfo:nil];
    reject(@"加密失败",@"加密失败",error);
  }
}

RCT_EXPORT_METHOD(AESEncryptByCallBack:(NSString *)message withKey:(NSString *)encryptKey callback:(RCTResponseSenderBlock)callback){
    NSString *result=[Tools AESEncryptString:message withKey:encryptKey];
    callback(@[[NSNull null],result ]);
}

RCT_EXPORT_METHOD(AESEncryptByPromise:(NSString *)message withKey:(NSString *)encryptKey  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
  NSString *result=[Tools AESEncryptString:message withKey:encryptKey];
  if(![result isEqualToString:@""]){
    resolve(result);
  }else{
    NSError *error=[NSError errorWithDomain:@"我是Promise回调错误信息..." code:500 userInfo:nil];
    reject(@"加密失败",@"加密失败",error);
  }
}

RCT_EXPORT_METHOD(AESDecryptByCallBack:(NSString *)message withKey:(NSString *)encryptKey callback:(RCTResponseSenderBlock)callback){
  NSString *result=[Tools AESDecryptString:message withKey:encryptKey];
  callback(@[[NSNull null],result ]);
}

RCT_EXPORT_METHOD(AESDecryptByPromise:(NSString *)message withKey:(NSString *)encryptKey  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
  NSString *result=[Tools AESDecryptString:message withKey:encryptKey];
  if(![result isEqualToString:@""]){
    resolve(result);
  }else{
    NSError *error=[NSError errorWithDomain:@"我是Promise回调错误信息..." code:500 userInfo:nil];
    reject(@"解密失败",@"解密失败",error);
  }
}

@end
