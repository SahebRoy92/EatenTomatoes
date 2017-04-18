//
//  ETMovieModel.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETMovieModel.h"

@implementation ETMovieModel

- (instancetype)init{
    if([super init]){
        [self loadDefaultValues];
    }
    return self;
}


- (void)loadDefaultValues{
    
    self.title              = @"";
    self.releaseDate        = @"";
    self.posterurl          = @"";
    self.plot               = @"";
    self.actor              = @"";
    self.genre              = @"";
    self.runtime            = @"";
    self.director           = @"";
    self.language           = @"English";
    self.type               = @"movie";
    self.production         = @"";
    self.imdbID             = @"";
    self.imdbRating         = @"";
    self.rtRating           = @"";
    self.metacriticRating   = @"";
}

@end
