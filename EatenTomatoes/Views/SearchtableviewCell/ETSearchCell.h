//
//  ETSearchCell.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 17/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETSearchCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UITextField *txtField;
@property (nonatomic,weak) IBOutlet UILabel *lblTitle;
@property (nonatomic,weak) IBOutlet UIButton *button;
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;
@end
