//
//  SRReachability.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {

    kSRNoNetwork,
    kSRisNetwork

}SRReachabilityFlags;


@interface SRReachability : NSObject


@property (nonatomic,strong) UIColor *noNetworkcolor;
@property (nonatomic,strong) UIColor *isNetworkcolor;
@property (nonatomic,assign) SRReachabilityFlags currentNetworkStatus;


+ (instancetype)manager;

@end
