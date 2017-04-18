//
//  Constraints.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#ifndef Constraints_h
#define Constraints_h


/*----------------- IMPORTS -------------------*/

#import "ETCommon.h"
#import "ETGlobal.h"
#import "ServiceManager.h"
#import "UIAlertController+Window.h"
#import "ETNavigationHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SRPickerView.h"
#import <SpinKit/RTSpinKitView.h>
#import <MBProgressHUD.h>

/*----------------- CONSTANTS -------------------*/

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
#define THEME_Color [UIColor colorWithRed:228.0f/255 green:17.0f/255 blue:31.0f/255 alpha:1.0]



/*----------------- SEGUE AND STORYBOARD ID -------------------*/


#define kFromSplashToSettingsController         @"fromSplashToSettingsControllerSegue"
#define kFromHomeToDetailsController            @"fromHometoDetailControllerSegue"
#define kFromSettingsToHomeController           @"fromSettingsToHomeSegue"



#endif /* Constraints_h */
