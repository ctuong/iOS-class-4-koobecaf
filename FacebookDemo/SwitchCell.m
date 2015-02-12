//
//  SwitchCell.m
//  FacebookDemo
//
//  Created by Calvin Tuong on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.optionValue addTarget:self action:@selector(toggled) forControlEvents:UIControlEventValueChanged];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:YES];
}

-(void)toggled {
    if ([self respondsToSelector:@selector(delegate)]) {
        [self.delegate switchCell:self toValue:self.optionValue.selected];
    }
}

@end
