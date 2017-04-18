//
//  SRPickerView.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 17/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SRPickerCompletionBlock) (NSString *strPicked, int indexOfItem);

@interface SRPickerView : UIView

- (void)configureWithItems:(NSArray *)allitems isDate:(BOOL)isDate andCompletion:(SRPickerCompletionBlock)completionBlock;

@end
