// http://www.wuleilei.com/

#import "StringEncryption.h"
#import "NSData+Base64.h"

//#define kEncryptKey @"wIEuw3kAGwVNl7BW" // 加密用的key  wIEuw3kAGwVNl7BWCdmptuL6tAIjNcAq

#if DEBUG
#define LOGGING_FACILITY(X, Y)	\
NSAssert(X, Y);	

#define LOGGING_FACILITY1(X, Y, Z)	\
NSAssert1(X, Y, Z);	
#else
#define LOGGING_FACILITY(X, Y)	\
if(!(X)) {			\
ZTTLog(Y);		\
exit(-1);		\
}					

#define LOGGING_FACILITY1(X, Y, Z)	\
if(!(X)) {				\
ZTTLog(Y, Z);		\
exit(-1);			\
}						
#endif

@implementation StringEncryption

CCOptions _padding = kCCOptionPKCS7Padding;

+ (NSString *)encryptString:(NSString *)plainSourceStringToEncrypt withKey:(NSString *)encryptKey
{
  
	NSData *_secretData = [plainSourceStringToEncrypt dataUsingEncoding:NSASCIIStringEncoding];
		
	// You can use md5 to make sure key is 16 bits long
	NSData *encryptedData = [self encrypt:_secretData withKey:encryptKey];
		
	return [encryptedData base64EncodingWithLineLength:0];	
}

+ (NSString *)decryptString:(NSString *)base64StringToDecrypt withKey:(NSString *)encryptKey
{
	NSData *data = [StringEncryption decrypt:[NSData dataWithBase64EncodedString:base64StringToDecrypt] withKey:encryptKey];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)encrypt:(NSData *)plainText withKey:(NSString *)encryptKey
{
    return [self doCipher:plainText context:kCCEncrypt withKey:encryptKey];
}

+ (NSData *)decrypt:(NSData *)plainText withKey:(NSString *)encryptKey
{
    return [self doCipher:plainText context:kCCDecrypt withKey:encryptKey];
}

+ (NSData *)doCipher:(NSData *)plainText context:(CCOperation)encryptOrDecrypt withKey:(NSString *)encryptKey
{
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
    CCOptions *pkcs7;
    pkcs7 = &_padding;
    NSData *aSymmetricKey = [encryptKey dataUsingEncoding:NSUTF8StringEncoding];
	
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kChosenCipherBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
	
    plainTextBufferSize = [plainText length];
	
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            if((plainTextBufferSize % kChosenCipherBlockSize) == 0) {
                *pkcs7 = 0x0000;
            } else {
                *pkcs7 = kCCOptionPKCS7Padding;
            }
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
//        ZTTLog(@"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
    }
	
    // Create and Initialize the crypto reference.
    ccStatus = CCCryptorCreate(encryptOrDecrypt,
                               kCCAlgorithmAES128,
                               *pkcs7,
                               (const void *)[aSymmetricKey bytes],
                               kChosenCipherKeySize,
                               (const void *)iv,
                               &thisEncipher
                               );
	
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
    // Initialize some necessary book keeping.
    ptr = bufferPtr;
	
    // Set up initial size.
    remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    ccStatus = CCCryptorUpdate(thisEncipher,
                               (const void *) [plainText bytes],
                               plainTextBufferSize,
                               ptr,
                               remainingBytes,
                               &movedBytes
                               );
	
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
	
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
	
    totalBytesWritten += movedBytes;
	
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
	
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
	
    if(bufferPtr) free(bufferPtr);
	
    return cipherOrPlainText;
}

@end