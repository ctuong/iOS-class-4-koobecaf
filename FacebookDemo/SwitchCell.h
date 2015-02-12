//
//  SwitchCell.h
//  FacebookDemo
//
//  Created by Calvin Tuong on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

-(void)switchCell:(id)switchCell toValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *optionValue;
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) id<SwitchCellDelegate> delegate;

@end
