//
//  SUtils.h
//  Foods
//
//  Created by Wony Shin on 01/03/2012.
//  Copyright 2011 __Cheng Tong IT Inc__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SUtils : NSObject {

}

+(NSString *)getFilePath:(NSString *)fileName;
+(BOOL)isFileInDocumentDirectory:(NSString *)fileName;
+(void)copyFileToDocumentDirectory:(NSString *)fileName;
+(NSString *)getDocumentDirectory;
+(NSString *)generateFileName: (BOOL) bMovie;
+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
+(NSString *)convertToLocalTime:(NSString *)GMTtime;
+(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
@end
