//
//  ERNavigationHandler.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum {
    kETHome,
    kETDetails,
    kETSearch
    
}ETNavigationType;

@protocol ETNavigationHandlerObserver <NSObject>

- (void)setTopBarType:(ETNavigationType)type andTitle:(NSString *)title;

@end


@interface ETNavigationHandler : NSObject

+ (instancetype)sharedManager;
- (void)setNavigation:(ETNavigationType)type andTitle:(NSString *)title;


@property (nonatomic,weak) id <ETNavigationHandlerObserver> observer;



@end
