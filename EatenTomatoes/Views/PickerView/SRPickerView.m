//
//  SRPickerView.m
//  EatenTomatoes
//
//  Created by Saheb Roy on 17/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import "SRPickerView.h"
#import "Constraints.h"

@interface SRPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,copy) SRPickerCompletionBlock completionBlock;
@end

@implementation SRPickerView{
    UIView *maskView, *pickerBackview;
    UIPickerView *picker;
    UIButton *doneButton;
    NSArray *items;
}


- (instancetype)init{
    if([super init]){
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
    }
    return self;

}


- (void)configureWithItems:(NSArray *)allitems isDate:(BOOL)isDate andCompletion:(SRPickerCompletionBlock)completionBlock{
    
    self.completionBlock = completionBlock;
    items = allitems;

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    pickerBackview = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height + 10, self.bounds.size.width, 220)];
    pickerBackview.backgroundColor = [UIColor whiteColor];
    
    doneButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:THEME_Color forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(didPickItem) forControlEvents:UIControlEventTouchUpInside];
    [pickerBackview addSubview:doneButton];
    
    
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, 180)];
    picker.dataSource = self;
    picker.delegate = self;
    [pickerBackview addSubview:picker];

    if(isDate){
        NSMutableArray *allYear = [@[]mutableCopy];
        for (int i = 1940; i<2017; i++) {
            [allYear addObject:[NSString stringWithFormat:@"%i",i]];
        }
        items = allYear;
    }
    
    
    self.alpha = 0.0;
    [self addSubview:pickerBackview];
    [self performShowingAnimation];
    
}


- (void)performShowingAnimation{
    CGRect outofBoundFrame = pickerBackview.frame;
    outofBoundFrame.origin.y -= pickerBackview.frame.size.height + 10;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            pickerBackview.frame = outofBoundFrame;
        }];
    }];

}

- (void)performDismissAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self cleanup];
        [self removeFromSuperview];
    }];;
}


#pragma mark - Action

- (void)didPickItem{
    if(self.completionBlock){
        int currentIndex = (int)[picker selectedRowInComponent:0];
        NSString *itemSelected = [items objectAtIndex:currentIndex];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock(itemSelected,currentIndex);
        });
    }
    [self performDismissAnimation];
}

- (void)cleanup{
    picker = nil;
    pickerBackview = nil;
    doneButton = nil;
    items = nil;
}


#pragma mark - Picker Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return items[row];
}


@end
