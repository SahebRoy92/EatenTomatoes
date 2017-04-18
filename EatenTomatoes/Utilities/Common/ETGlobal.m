//
//  ETGlobal.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 12/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "ETGlobal.h"
#import "Constraints.h"


NSString * const ALERT_TITLE    = @"Eaten Tomatoes";
NSString * const BASEURL        = @"http://www.omdbapi.com/?";
int const spinnertag            = 10007;


@implementation ETGlobal


BOOL isNullString(NSString* _inputString) {
    NSString *InputString=_inputString;
    if( (InputString == nil) ||(InputString ==(NSString *)[NSNull null])||([InputString isEqual:nil])||([InputString length] == 0)|| [[InputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0||([InputString isEqualToString:@""])||([InputString isEqualToString:@"(NULL)"])||([InputString isEqualToString:@"<NULL>"])||([InputString isEqualToString:@"<null>"]||([InputString isEqualToString:@"(null)"])||([InputString isEqualToString:@"nil"])||([InputString isEqualToString:@"Nil"])||([InputString isEqualToString:@""])))
        return YES;
    else
        return NO ;
    
}



void showSimpleAlert(NSString *description){
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:description preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil] ];
    [alert show];
    
}

void showAlertWithDescAndAction(NSString *desc,NSArray *actions ,alertActionBlock completion){
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:desc preferredStyle:UIAlertControllerStyleAlert];
    
    if (actions && [actions count] > 0) {
        for (int i = 0; i < [actions count]; i++) {
            UIAlertAction* action = [UIAlertAction
                                     actionWithTitle:[actions objectAtIndex:i]
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         if (completion != NULL) {
                                             for (int j = 0; j < [[alert actions] count]; j++) {
                                                 UIAlertAction *clickedAction = [[alert actions] objectAtIndex:j];
                                                 if (clickedAction == action) {
                                                     completion(j);
                                                     break;
                                                 }
                                             }
                                         }
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
            [alert addAction:action];
        }
        [alert show];
    }
    
}



void addSubViewOnWindow(UIView *subView){
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            subView.tag = 10005;
            [window addSubview:subView];
            break;
        }
    }
}

void removeSubviewFromWindow(){
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [[window viewWithTag:10005]removeFromSuperview];
            break;
        }
    }
}


float sizeOfLabel(NSString *str, float maxWidth){
  
    
     CGRect labelRect = [str boundingRectWithSize:CGSizeMake(maxWidth,FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    return labelRect.size.height;
}


void showLoader(NSString *str){
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleThreeBounce color:[UIColor darkGrayColor]];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.label.textColor = [UIColor darkGrayColor];
    hud.label.text = str;
    hud.tag = spinnertag;
    [spinner startAnimating];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
}

void hideLoader() {
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    [[[UIApplication sharedApplication].keyWindow viewWithTag:spinnertag] removeFromSuperview];
}


@end
