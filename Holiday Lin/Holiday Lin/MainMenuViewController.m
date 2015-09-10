//
//  MainMenuViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/8/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@property (strong, nonatomic)UITableView *tableView;

@end

@implementation MainMenuViewController

-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc]init];
  [rootView addSubview:self.tableView];
  self.tableView.backgroundColor = [UIColor blueColor];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSDictionary *views = @{@"tableView":self.tableView};
  
  NSArray *tableViewHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontalConstraint];
  
  NSArray *tableViewVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVerticalConstraint];
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
