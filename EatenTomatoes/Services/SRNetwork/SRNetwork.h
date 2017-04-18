//
//  SRNetwork.h
//  NetworkManager
//
//  Created by Saheb Roy on 03/02/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SRNetwork : NSObject

+(void)postToServerWithURL:(NSString *)url andParameter:(NSDictionary *)parameter andSuccess:(void (^)(id responseObj))successBlock andFailure:(void (^)(NSError *error , NSString *errorMsg))failureBlock;


+(void)getDataFromServerWithURL:(NSString *)url andParameter:(NSDictionary *)parameter andSuccess:(void (^)(id responseObject))successBlock andFailure:(void(^)(NSError *error,  NSString *errorMsg))failureBlock;

+ (void)uploadWithMultiPartRequest:(NSDictionary *)parameter imageData:(NSData *)fileData imageURL:(NSURL *)fileURL fileParamName:(NSString *)fileParamName apiURL:(NSString *)apiURL andSuccess:(void (^)(id responseObject , NSInteger statusCode))successBlock andFailure:(void(^)(NSError *error,  NSString *errorMsg))failureBlock;




@end
