//
//  MD5Encrypt.h
//  加密
//
//  Created by 紫川秀 on 2018/1/19.
//  Copyright © 2018年 View. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encrypt : NSObject

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

@end
