//
//  SRReachability.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//
#define isiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define viewTag  100
#import "SRReachability.h"
#import <AFNetworkReachabilityManager.h>


@interface SRReachability()

@property (nonatomic,strong) UIView     *networkView;
@property (nonatomic,strong) UILabel    *lblNetwokTitle;

@end

@implementation SRReachability

+ (instancetype)manager{
    static SRReachability *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SRReachability alloc]init];
        [manager setupManager];
    });
    return manager;
}


- (void)setupManager{
    
    self.noNetworkcolor = [UIColor darkGrayColor];
    self.isNetworkcolor = [UIColor greenColor];
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
               self.currentNetworkStatus = kSRNoNetwork;
                break;
            default:
                 self.currentNetworkStatus = kSRisNetwork;
                break;
        }
        [self currentStatusReachability];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}


- (void)currentStatusReachability{
    switch (self.currentNetworkStatus) {
        case kSRisNetwork:
            [self showNetworkFlag];
            break;
        case kSRNoNetwork:
            [self showNoNetworkFlag];
            break;
        default:
            break;
    }
}


- (void)showNoNetworkFlag{
    
    [self.networkView removeFromSuperview];
    self.networkView.backgroundColor = self.noNetworkcolor;
    self.lblNetwokTitle.text = @"No Network";
    [self.networkView addSubview:self.lblNetwokTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.networkView];

    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:1 animations:^{
        CGRect frame = self.networkView.frame;
        frame.origin.y = 0;
        self.networkView.frame = frame;
    } completion:^(BOOL finished) {

    }];
    
}


- (void)showNetworkFlag{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.7 options:1 animations:^{
        CGRect frame = self.networkView.frame;
        frame.origin.y -= self.networkView.frame.size.height - 10;
        self.networkView.frame = frame;
    } completion:^(BOOL finished) {
        [self.networkView removeFromSuperview];
    }];
}


#pragma mark - Getters

- (UILabel *)lblNetwokTitle{
    if(_lblNetwokTitle == nil){
        _lblNetwokTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,18, self.networkView.frame.size.width, self.networkView.frame.size.height - 18)];
        _lblNetwokTitle.textColor = [UIColor whiteColor];
        _lblNetwokTitle.font = [UIFont systemFontOfSize:isiPad?20:12];
        _lblNetwokTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lblNetwokTitle;
}

- (UIView *)networkView{
    if(_networkView == nil){
        _networkView = [[UIView alloc]initWithFrame:CGRectMake(0, -isiPad?45:35,[[UIScreen mainScreen] bounds].size.width, isiPad?45:35)];
        _networkView.tag = viewTag;
    }
    return _networkView;
}



@end
