//
//  StringEncryptioned.h
//  GSM
//
//  Created by ztt on 16/3/8.
//  Copyright © 2016年 QYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH
@interface StringEncryptioned : NSObject

@end
