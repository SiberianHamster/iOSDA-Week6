//
//  ViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/7/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "Room.h"
#import "HotelListViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableViewCell *tableViewCell;
@property(strong, nonatomic) NSArray *hotels;
@property(strong,nonatomic) Hotel *hotel;
@end

@implementation ViewController

-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc] init];
  self.tableView.backgroundColor = [UIColor whiteColor];
  [rootView addSubview:self.tableView];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSDictionary *views = @{@"tableView":self.tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.dataSource = self;
  self.tableView.delegate  = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  self.hotels = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  
  if (fetchError) {
    NSLog(@"Error %@", fetchError.localizedDescription);
  }
  
  [self.tableView reloadData];

  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
  self.hotel = self.hotels[indexPath.row];
  cell.textLabel.text = self.hotel.name;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  HotelListViewController *hotelListViewController = [[HotelListViewController alloc]init];
  hotelListViewController.hotel = self.hotels[indexPath.row];
  
  Hotel *asdf = self.hotels[indexPath.row];
  
  NSLog(@"Room Count: %lu",(unsigned long)asdf.rooms.count);
  
//  [self.navigationController showDetailViewController:hotelListViewController sender: self];
  [self.navigationController pushViewController:hotelListViewController animated:YES];
  
}

@end
