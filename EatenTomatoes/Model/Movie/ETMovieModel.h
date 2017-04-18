//
//  ETMovieModel.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETMovieModel : NSObject


@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *releaseDate;
@property (nonatomic,strong) NSString *posterurl;
@property (nonatomic,strong) NSString *plot;
@property (nonatomic,strong) NSString *actor;
@property (nonatomic,strong) NSString *genre;
@property (nonatomic,strong) NSString *runtime;
@property (nonatomic,strong) NSString *director;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *type; // movie/series
@property (nonatomic,strong) NSString *production;
@property (nonatomic,strong) NSString *imdbID;


@property (nonatomic,strong) NSString *imdbRating;
@property (nonatomic,strong) NSString *rtRating;
@property (nonatomic,strong) NSString *metacriticRating;
@end
