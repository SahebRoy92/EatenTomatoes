//
//  ETDetailHeaderCell.h
//  EatenTomatoes
//
//  Created by Saheb Roy on 18/04/17.
//  Copyright © 2017 Saheb Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETDetailHeaderCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *posterImage;

@property (nonatomic,weak) IBOutlet UIView *vwRT;
@property (nonatomic,weak) IBOutlet UIView *vwMC;
@property (nonatomic,weak) IBOutlet UIView *vwIMDB;

@property (nonatomic,weak) IBOutlet UILabel *lblRT;
@property (nonatomic,weak) IBOutlet UILabel *lblMC;
@property (nonatomic,weak) IBOutlet UILabel *lblIMDB;

@end
