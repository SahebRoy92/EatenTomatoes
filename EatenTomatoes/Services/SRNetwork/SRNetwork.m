//
//  SRNetwork.m
//  NetworkManager
//
//  Created by Saheb Roy on 03/02/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//



#import <AFNetworking.h>
#import "SRNetwork.h"

@implementation SRNetwork

+(void)postToServerWithURL:(NSString *)url andParameter:(NSDictionary *)parameter andSuccess:(void (^)(id responseObj))successBlock andFailure:(void (^)(NSError *error , NSString *errorMsg))failureBlock{
    
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            if(responseObject !=nil){
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            @try {

                
                if (error.code == NSURLErrorTimedOut) {
                    //time out error here
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                    });
                    failureBlock(error,@"It seems your internet connection is too slow");
                }
                
            }
            @catch (NSException *exception) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                });
                failureBlock(error,@"Something went wrong, Please try again");
            }
            @finally {
                
            }
            
        }];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/x-www-form-urlencoded",@"text/html", nil];
        
        
        
    }
    else{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            failureBlock (nil,@"It seems you are not connected to the network. Please reconnect and try again");
            
        });
        
    }
    
    
    
}

+(void)getDataFromServerWithURL:(NSString *)url andParameter:(NSDictionary *)parameter andSuccess:(void (^)(id responseObject))successBlock andFailure:(void(^)(NSError *error,  NSString *errorMsg))failureBlock{
    
    
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]){
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(responseObject !=nil){
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSError* errorDic;
            if(data !=nil){
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&errorDic];
                
                NSString *str = [json valueForKey:@"ResponseDetails"];
                if(str == nil){
                    str = @"Something went wrong. Please try again";
                }
                failureBlock(error,str);
                
            }
            failureBlock(error,@"Something went wrong. Please try again");
            
        }];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        
    }
    else{
        failureBlock (nil,nil);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             failureBlock (nil,@"It seems you are not connected to the network. Please reconnect and try again");
        });
    }
    
    
}

+ (void)uploadWithMultiPartRequest:(NSDictionary *)parameter imageData:(NSData *)fileData imageURL:(NSURL *)fileURL fileParamName:(NSString *)fileParamName apiURL:(NSString *)apiURL andSuccess:(void (^)(id responseObject , NSInteger statusCode))successBlock andFailure:(void(^)(NSError *error,  NSString *errorMsg))failureBlock {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:apiURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if(fileData) {
                [formData appendPartWithFileData:fileData name:fileParamName fileName:@"profilePic" mimeType:@"image/jpeg"];
            } else if(fileURL) {
                [formData appendPartWithFileURL:fileURL name:fileParamName fileName:@"profilePic" mimeType:@"image/jpeg" error:nil];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"UPLOAD ---- %lli",(uploadProgress.completedUnitCount/uploadProgress.totalUnitCount) * 100);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSInteger statusCode = [[responseObject objectForKey:@"ResponseCode"] integerValue];
            if(responseObject !=nil){
                successBlock(responseObject,statusCode);
            }
            else
                failureBlock(nil,@"Something went wrong");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error,nil);
        }];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/x-www-form-urlencoded",@"text/html", nil];
    }
    else{
        failureBlock (nil,nil);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }
}

@end
