//
//  NSData+NSData_ST.h
//  zph
//
//  Created by 李龙 on 2017/1/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSData_ST)
- (NSData *)gzipUnpack;
+(NSData *)uncompressZippedData:(NSData *)compressedData;

+(NSData*) compressData: (NSData*)uncompressedData;

@end
