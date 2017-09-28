//
//  SUtils.m
//  Foods
//
//  Created by Wony Shin on 01/03/2012.
//  Copyright 2011 __Cheng Tong IT Inc__. All rights reserved.
//

#import "SUtils.h"


@implementation SUtils

+(NSString *)getDocumentDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}

+(NSString *)generateFileName: (BOOL) bMovie {
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMddyyyy_HH_mm_ss"];
    NSString *date_str = [dateFormatter stringFromDate:currDate];
    NSString *strFileName;
    
    if (bMovie == YES) {
        strFileName = [[[NSString alloc] initWithFormat:@"imageorganizer%@.mp4", date_str] autorelease];
    } else {
        strFileName = [[[NSString alloc] initWithFormat:@"imageorganizer%@.jpg", date_str] autorelease];
    }
    
    return strFileName;

}
	
+(NSString *)getFilePath:(NSString *)fileName
{
	NSArray *fileComponents = [NSArray arrayWithArray:[fileName componentsSeparatedByString:@"."]];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileComponents objectAtIndex:0] ofType:[fileComponents objectAtIndex:1]];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	BOOL isAtPath = [fileManager fileExistsAtPath:path];
	
	if(isAtPath)
	{
		return path;
	}
	else
	{
		return filePath;
	}
	
}

+(BOOL)isFileInDocumentDirectory:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isFileAtPath = [fileManager fileExistsAtPath:path];
	return isFileAtPath;
}

+(void)copyFileToDocumentDirectory:(NSString *)fileName
{
	NSString *pathOfFile = [self getFilePath:fileName];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *docDir = [self getDocumentDirectory];
	NSString *desFilePath = [docDir stringByAppendingPathComponent:fileName];
	if([self isFileInDocumentDirectory:fileName])
	{
		
	}
	else
	{
		[fileManager copyItemAtPath:pathOfFile toPath:desFilePath error:nil];
	}
}


+(NSString *)convertToLocalTime:(NSString *)GMTtime
{
    NSString *serverDateString = GMTtime;
    NSDateFormatter *serverDateFormatter = [[NSDateFormatter alloc] init];
    [serverDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromServer = [serverDateFormatter dateFromString:serverDateString];
    [serverDateFormatter release];
    
    NSDateFormatter *dateFormatConverter = [[NSDateFormatter alloc] init];
    [dateFormatConverter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    /////////// GMT Logic ////
    NSDate* sourceDate = dateFromServer;
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] autorelease];
    /////// End GMT Logic /////
    
    NSString *localDate = [dateFormatConverter stringFromDate:destinationDate];
    
    [dateFormatConverter release];
    
    return localDate;
    
}



+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


+(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    float width = size.width;
    float height = size.height;
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height; 
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor; 
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();   
    
    return smallImage;
}


	
@end
