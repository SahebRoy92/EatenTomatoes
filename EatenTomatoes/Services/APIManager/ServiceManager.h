//
//  ServiceManager.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETMovieModel.h"

@interface ServiceManager : NSObject


+ (instancetype)sharedManager;

- (void)getMoviesWithReleaseDate:(NSString *)releaseDate andSearchText:(NSString *)searchText andType:(NSString *)type withCompletion:(void (^)(id))successBlock andFailure:(void (^)(NSString *))failureBlock;

- (void)getMovieDetails:(ETMovieModel *)model withCompletion:(void (^)(id response))successBlock andFailure:(void (^)(NSString *alert))failureBlock;
@end
