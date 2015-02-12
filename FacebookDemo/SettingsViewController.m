//
//  SettingsViewController.m
//  FacebookDemo
//
//  Created by Calvin Tuong on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import "SettingsViewController.h"
#import "SwitchCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (strong, nonatomic) NSMutableDictionary *values;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseButton)];
    self.navigationItem.leftBarButtonItem = closeButton;
    
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    self.navigationItem.rightBarButtonItem = applyButton;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.values = [NSMutableDictionary dictionary];
}

- (void)onCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    // SAVE!
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    switch (indexPath.row) {
        case 0:
            cell.optionLabel.text = @"Links";
            break;
        case 1:
            cell.optionLabel.text = @"Statuses";
            break;
        case 2:
            cell.optionLabel.text = @"Photos";
            break;
        case 3:
            cell.optionLabel.text = @"Videos";
            break;
    }
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.values setValue:cell forKey:key];
    //cell.optionValue.selected = [self getValueForRow:indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)switchCell:(id)switchCell toValue:(BOOL)value {
    NSInteger updatedRow = [self.tableView indexPathForCell:switchCell].row;
    //NSString *setKey = [NSString stringWithFormat:@"%ld", row];
    for (int i = 0; i < 4; i++) {
        NSString *key = [NSString stringWithFormat:@"%i", i];
        SwitchCell *cell = (SwitchCell *)self.values[key];
        if (i != updatedRow) {
            NSLog([NSString stringWithFormat:@"Cell %d was updated", i]);
            //cell.optionValue
            cell.optionValue.on = NO;
        }
    }
}

-(BOOL)getValueForRow:(NSInteger)row {
    NSString *key = [NSString stringWithFormat:@"%ld", (long)row];
    if (self.values[key] == nil) {
        [self.values setValue:[[NSNumber alloc] initWithBool:false] forKey:key];
    }
    return [self.values[key] boolValue];
}

-(void)setRow:(NSInteger)row toValue:(BOOL)value {
    NSString *key = [NSString stringWithFormat:@"%ld", (long)row];
    for (int i = 0; i < 4; i++) {
        NSString *key = [NSString stringWithFormat:@"%i", i];
        [self.values setValue:[[NSNumber alloc] initWithBool:false] forKey:key];
    }
    [self.values setValue:[[NSNumber alloc] initWithBool:value] forKey:key];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
