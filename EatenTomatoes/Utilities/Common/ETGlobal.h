//
//  ETGlobal.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^alertActionBlock) (int);

@interface ETGlobal : NSObject

/*---------  STRINGS ----------*/

extern NSString * const ALERT_TITLE;
extern NSString * const BASEURL;

/*---------  METHODS ----------*/

extern BOOL isNullString(NSString *inputString);
extern BOOL isValidEmail(NSString *checkString);
extern void showSimpleAlert(NSString *description);
extern void showAlertWithDescAndAction(NSString *desc,NSArray *actions ,alertActionBlock completion);
extern void addSubViewOnWindow(UIView *subView);
extern void removeSubviewFromWindow();
extern float sizeOfLabel(NSString *str, float maxWidth);
extern void showLoader(NSString *str);
extern void hideLoader();
@end
