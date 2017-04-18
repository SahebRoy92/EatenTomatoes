//
//  ServiceManager.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ServiceManager.h"
#import "SRNetwork.h"
#import "Constraints.h"


@implementation ServiceManager

+ (instancetype)sharedManager{
    static ServiceManager *apiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[ServiceManager alloc]init];
    });
    return apiManager;
}

- (void)getMoviesWithReleaseDate:(NSString *)releaseDate andSearchText:(NSString *)searchText andType:(NSString *)type withCompletion:(void (^)(id))successBlock andFailure:(void (^)(NSString *))failureBlock{

    NSMutableDictionary *param = [@{}mutableCopy];
    if(!isNullString(releaseDate)){
        [param setObject:releaseDate forKey:@"y"];
    }
    
    if(isNullString(searchText)){
        [param setObject:@"2017" forKey:@"y"];
    }else {
        [param setObject:searchText forKey:@"s"];
    }
    
    if(!isNullString(type)){
        [param setObject:type forKey:@"type"];
    }
    
    [param setObject:@"json" forKey:@"r"];
    [param setObject:[NSString stringWithFormat:@"%i",[ETCommon sharedManager].currentPage] forKey:@"page"];
    
    [SRNetwork getDataFromServerWithURL:BASEURL andParameter:param andSuccess:^(id responseObject) {
        if([[responseObject valueForKey:@"Response"]isEqualToString:@"True"]){
           successBlock(responseObject);
        }else {
            NSString *str = [responseObject valueForKey:@"Error"];
            failureBlock(str);
        }
    } andFailure:^(NSError *error, NSString *errorMsg) {
        failureBlock(errorMsg);
    }];
    
}


- (void)getMovieDetails:(ETMovieModel *)model withCompletion:(void (^)(id response))successBlock andFailure:(void (^)(NSString *alert))failureBlock{
    
    NSDictionary *param = @{@"i":model.imdbID};
    
    
    [SRNetwork getDataFromServerWithURL:BASEURL andParameter:param andSuccess:^(id responseObject) {
        
        if([[responseObject valueForKey:@"Response"]isEqualToString:@"True"]){
            

            model.title         = [responseObject valueForKey:@"Title"];
            model.releaseDate   = [responseObject valueForKey:@"Released"];
            model.director      = [responseObject valueForKey:@"Director"];
            model.title         = [responseObject valueForKey:@"Title"];
            model.plot          = [responseObject valueForKey:@"Plot"];
            model.posterurl     = [responseObject valueForKey:@"Poster"];
            model.type          = [responseObject valueForKey:@"Type"];
            model.actor         = [responseObject valueForKey:@"Actors"];
            model.genre         = [responseObject valueForKey:@"Genre"];
            model.runtime       = [responseObject valueForKey:@"Runtime"];
            model.language      = [responseObject valueForKey:@"Language"];
            model.production    = [responseObject valueForKey:@"Production"];
            
            
            for (NSDictionary *dic in [responseObject valueForKey:@"Ratings"]) {
                if([[dic valueForKey:@"Source"]isEqualToString:@"Metacritic"]){
                    model.metacriticRating = [dic valueForKey:@"Value"];
                }
                else if ([[dic valueForKey:@"Source"]isEqualToString:@"Rotten Tomatoes"]){
                    model.rtRating = [dic valueForKey:@"Value"];
                }
                else if ([[dic valueForKey:@"Source"]isEqualToString:@"Internet Movie Database"]){
                    model.imdbRating = [dic valueForKey:@"Value"];
                }
            }
            
            successBlock(responseObject);
        }else {
            NSString *str = [responseObject valueForKey:@"Error"];
            failureBlock(str);
        }
        
        
    } andFailure:^(NSError *error, NSString *errorMsg) {
        failureBlock(errorMsg);
    }];

}


@end
