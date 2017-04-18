//
//  ETCommon.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ETCommon : NSObject

+ (instancetype)sharedManager;


@property (nonatomic,weak) UINavigationController *initialController;

/*------- APP LEVEL SETTINGS ---------*/

@property (nonatomic,assign) int currentPage;
@property (nonatomic,strong) NSString *searchstring;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *year;

@end
