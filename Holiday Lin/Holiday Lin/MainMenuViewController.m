//
//  MainMenuViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/8/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "HotelListViewController.h"
#import "ReservationViewController.h"

@interface MainMenuViewController ()
@property (strong, nonatomic) UIButton *hotelList;
@property (strong, nonatomic) UIButton *reservation;
@property (strong, nonatomic) UIButton *searchBooked;

@end

@implementation MainMenuViewController


-(void)loadView{
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.hotelList = [[UIButton alloc]init];
  self.reservation = [[UIButton alloc]init];
  self.searchBooked = [[UIButton alloc]init];
  
  [rootView addSubview:self.hotelList];
  [rootView addSubview:self.reservation];
  [rootView addSubview:self.searchBooked];
  
  [self.hotelList setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.reservation setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.searchBooked setTranslatesAutoresizingMaskIntoConstraints:false];
  
  [self.hotelList setTitle:@"Hotel Listing" forState:UIControlStateNormal];
  [self.reservation setTitle:@"Create Reservation" forState:UIControlStateNormal];
  [self.searchBooked setTitle:@"Search Reservation" forState:UIControlStateNormal];
  
  self.hotelList.backgroundColor = [UIColor blueColor];
  self.reservation.backgroundColor = [UIColor blueColor];
  self.searchBooked.backgroundColor = [UIColor blueColor];
  
  NSDictionary *views = @{@"hotelList":self.hotelList, @"reservation":self.reservation, @"searchBooked":self.searchBooked};
  
  NSArray *hotelListHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[hotelList]|" options:0 metrics:nil views:views];
  [rootView addConstraints:hotelListHorizontal];
  
  NSArray *reservationHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[reservation]|" options:0 metrics:nil views:views];
  [rootView addConstraints:reservationHorizontal];
  
  NSArray *searchBookedHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBooked]|" options:0 metrics:nil views:views];
  [rootView addConstraints:searchBookedHorizontal];
  
  NSArray *hotelVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[hotelList]" options:0 metrics:nil views:views];
  [rootView addConstraints:hotelVertical];
  
  NSArray *reservationVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[hotelList]-16-[reservation]" options:0 metrics:nil views:views];
  [rootView addConstraints:reservationVertical];
  
  NSArray *searchBookedVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[reservation]-16-[searchBooked]" options:0 metrics:nil views:views];
  [rootView addConstraints:searchBookedVertical];
  
  [self.hotelList addTarget:self action:@selector(goToHotelList:) forControlEvents:UIControlEventTouchUpInside];
[self.reservation addTarget:self action:@selector(goToReservation:) forControlEvents:UIControlEventTouchUpInside];
[self.searchBooked addTarget:self action:@selector(goToSearchBooked:) forControlEvents:UIControlEventTouchUpInside];
  
  self.view = rootView;
  
}

-(void)goToHotelList:(id)sender{
  ViewController *viewController = [[ViewController alloc]init];
  [self.navigationController pushViewController:viewController animated:true];
}

-(void)goToReservation:(id)sender{
  ReservationViewController *reservationVC = [[ReservationViewController alloc]init];
  [self.navigationController pushViewController:reservationVC animated:true];
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
