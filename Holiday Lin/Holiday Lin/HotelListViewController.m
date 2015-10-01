//
//  HotelListViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/9/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "HotelListViewController.h"
#import "Hotel.h"
#import "Room.h"

@interface HotelListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableViewCell *tableViewCell;
@property (strong, nonatomic) NSArray *rooms;

@end

@implementation HotelListViewController

-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc]init];
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
  
  self.tableView.dataSource  = self;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];
  
  self.rooms = [self.hotel.rooms allObjects];
//  NSLog(@"Rooms: %lu",(unsigned long)self.rooms.count);

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];
  Room *room = self.rooms[indexPath.row];
  cell.textLabel.text = [room.number stringValue];
  return cell;
}

@end
