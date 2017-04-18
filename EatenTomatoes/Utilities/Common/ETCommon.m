//
//  ETCommon.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETCommon.h"

@implementation ETCommon

+ (instancetype)sharedManager{
    static ETCommon *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ETCommon alloc]init];
        [manager configureManager];
    });
    return manager;
}


- (void)configureManager{
    self.searchstring = @"";
    self.year = @"";
    self.type = @"movie";
    self.currentPage = 1;
}

@end
