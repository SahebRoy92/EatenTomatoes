//
//  ETSplashVC.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//


#import "ETSplashVC.h"
#import "Constraints.h"

@interface ETSplashVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcTopLogo;
@property (weak, nonatomic) IBOutlet UIImageView *appNameImg;
@property (weak, nonatomic) IBOutlet UIImageView *appLogoImg;

@end

@implementation ETSplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureController];
}

- (void)configureController{
    self.lcTopLogo.constant = -200;
    self.appNameImg.hidden = YES;
    self.appNameImg.alpha = 0.0;
    self.appLogoImg.image = [UIImage imageNamed:@"prelogo1"];
    self.appLogoImg.contentMode = UIViewContentModeScaleAspectFit;
    self.appNameImg.contentMode = UIViewContentModeScaleAspectFit;
    self.appLogoImg.animationImages = @[[UIImage imageNamed:@"prelogo1"],[UIImage imageNamed:@"prelogo2"],[UIImage imageNamed:@"prelogo3"]];
    self.appLogoImg.animationRepeatCount = 1;
    self.appLogoImg.animationDuration = 1.2;
    
}

- (void)viewDidAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}


- (void)startAnimation{
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:1 animations:^{
        
        self.lcTopLogo.constant = 220;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.appLogoImg.image = [UIImage imageNamed:@"prelogo3"];
        [self.appLogoImg startAnimating];
         self.appNameImg.hidden = NO;
        
        [UIView animateWithDuration:0.3 delay:1.2 options:1 animations:^{
            
            self.appLogoImg.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-23));
            self.appLogoImg.image = [UIImage imageNamed:@"prelogo1"];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                 self.appNameImg.alpha = 1.0;
            } completion:^(BOOL finished) {
                [self moveImageToPosition];
            }];
        }];
        
    }];
}


- (void)moveImageToPosition{
    
    
    CGRect frameName = CGRectMake(self.view.center.x - 80, 11, 160, 60);
    CGRect frameLogo = CGRectMake(frameName.size.width + frameName.origin.x - 44 , 5, 50, 45);
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.appNameImg.frame = frameName;
        self.appLogoImg.image = [UIImage imageNamed:@"prelogo3"];
        self.appLogoImg.frame = frameLogo;
    } completion:^(BOOL finished) {
         [self performSegueWithIdentifier:kFromSplashToSettingsController sender:self];
    }];
   
}




@end
