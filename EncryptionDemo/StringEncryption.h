// http://www.wuleilei.com/

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>
#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

@interface StringEncryption : NSObject

+ (NSString *)encryptString:(NSString *)plainSourceStringToEncrypt withKey:(NSString *)encryptKey;
+ (NSString *)decryptString:(NSString *)base64StringToDecrypt withKey:(NSString *)encryptKey;
+ (NSData *)encrypt:(NSData *)plainText withKey:(NSString *)encryptKey;
+ (NSData *)decrypt:(NSData *)plainText withKey:(NSString *)encryptKey;
+ (NSData *)doCipher:(NSData *)plainText context:(CCOperation)encryptOrDecrypt withKey:(NSString *)encryptKey;

@end
