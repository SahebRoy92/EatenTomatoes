//
//  ERNavigationHandler.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETNavigationHandler.h"

@implementation ETNavigationHandler


+ (instancetype)sharedManager{
    static ETNavigationHandler *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ETNavigationHandler alloc]init];
    });
    return manager;
}





- (void)setNavigation:(ETNavigationType)type andTitle:(NSString *)title{
    if(self.observer && [self.observer respondsToSelector:@selector(setTopBarType:andTitle:)]){
        [self.observer setTopBarType:type andTitle:title];
    }
}


@end
