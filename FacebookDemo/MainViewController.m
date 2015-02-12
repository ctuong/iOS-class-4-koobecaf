//
//  MainViewController.m
//  FacebookDemo
//
//  Created by Timothy Lee on 10/22/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

#import "MainViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "StatusCell.h"
#import "PhotoCell.h"
#import "SettingsViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

- (void)reload;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellReuseIdentifier:@"PhotoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StatusCell" bundle:nil] forCellReuseIdentifier:@"StatusCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onRightButton {
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    UINavigationController *snc = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:snc animated:YES completion:^{
        // Do nothing?
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSString *)getMessageFromPost:(NSDictionary *)post {
    if (post[@"message"]) return post[@"message"];
    return post[@"story"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *post = self.posts[indexPath.row];
    if (post[@"picture"]) {
        PhotoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        
        cell.messageLabel.text = [self getMessageFromPost:post];
        NSURL *url = [NSURL URLWithString:post[@"picture"]];
        [cell.pictureView setImageWithURL:url];
        
        return cell;
    } else {
        StatusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"StatusCell"];
        
        cell.statusLabel.text = [self getMessageFromPost:post];
        
        return cell;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private methods

- (void)reload {
    [FBRequestConnection startWithGraphPath:@"/me/home"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              //NSLog(@"result: %@", result);
                              self.posts = result[@"data"];
                              [self.tableView reloadData];
                          }];
}

@end
