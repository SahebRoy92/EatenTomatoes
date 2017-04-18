//
//  ETTopVC.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 13/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETTopVC.h"
#import "ETNavigationHandler.h"
#import "Constraints.h"

@interface ETTopVC ()<ETNavigationHandlerObserver>

@property (nonatomic,weak) IBOutlet UILabel     *lblTitle;
@property (nonatomic,weak) IBOutlet UIButton    *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *appName;
@property (weak, nonatomic) IBOutlet UIImageView *appLogo;

@end

@implementation ETTopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    ETNavigationHandler *handler = [ETNavigationHandler sharedManager];
    handler.observer = weakSelf;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTopBarType:(ETNavigationType)type andTitle:(NSString *)title{
    [self setLabelValue:title];
    switch (type) {
        case kETHome:
            [self configureForHome];
            break;
            
        case kETSearch:
             [self configureForSearch];
            break;
            
        case kETDetails:
             [self configureForDetails];
            break;
            
        default:
            break;
    }
}



- (IBAction)goBackAction:(id)sender{
    [[ETCommon sharedManager].initialController popViewControllerAnimated:YES];
}


#pragma mark - Configure Methods 


- (void)setLabelValue:(NSString *)lblTitle{
    if(isNullString(lblTitle)){
        self.lblTitle.text = @"";
        self.lblTitle.hidden = YES;
    }else {
        self.lblTitle.text = lblTitle;
        self.lblTitle.hidden = NO;
    }

}

- (void)configureForHome{
    self.lblTitle.hidden    = YES;
    self.btnBack.hidden     = NO;
    self.appLogo.hidden     = NO;
    self.appName.hidden     = NO;

}


- (void)configureForSearch{
    self.lblTitle.hidden    = YES;
    self.btnBack.hidden     = YES;
    self.appLogo.hidden     = NO;
    self.appName.hidden     = NO;
    
}

- (void)configureForDetails{
    self.lblTitle.hidden    = NO;
    self.btnBack.hidden     = NO;
    self.appLogo.hidden     = YES;
    self.appName.hidden     = YES;
    
}



@end
