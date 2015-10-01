//
//  ConfirmReservationViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 10/1/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "ConfirmReservationViewController.h"
#import "ReservationViewController.h"
#import "Guest.h"
#import "Reservation.h"
#import "AppDelegate.h"

@interface ConfirmReservationViewController ()

@property (strong, nonatomic)UITextField *firstNameText;
@property (strong, nonatomic)UITextField *lastNameText;
@property (strong, nonatomic)UIButton *confirmButton;
@property (strong, nonatomic)UIView *rootView;

@end

@implementation ConfirmReservationViewController

- (void)loadView {

  self.rootView = [[UIView alloc]init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.firstNameText = [[UITextField alloc]init];
  self.lastNameText = [[UITextField alloc]init];
  self.confirmButton = [[UIButton alloc]init];
  
  [self.confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
  [self.firstNameText setText:@"First Name"];
  [self.lastNameText setText:@"Last Name"];
  [self.firstNameText setTextColor:[UIColor redColor]];
  [self.lastNameText setTextColor:[UIColor redColor]];
  [self.confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

  
  [self.rootView addSubview:self.firstNameText];
  [self.rootView addSubview:self.lastNameText];
  [self.rootView addSubview:self.confirmButton];
  
  [self.firstNameText setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.lastNameText setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.confirmButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSLayoutConstraint *firstNameLabelHorizantol = [NSLayoutConstraint constraintWithItem:self.firstNameText attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:firstNameLabelHorizantol];
  
  NSLayoutConstraint *lastNameLabelHorizantal = [NSLayoutConstraint constraintWithItem:self.lastNameText attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:lastNameLabelHorizantal];
  
  NSLayoutConstraint *buttonHorizantal = [NSLayoutConstraint constraintWithItem:self.confirmButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:buttonHorizantal];
  
  NSDictionary *views = [[NSDictionary alloc]init];
  views = @{@"firstNameText":self.firstNameText, @"lastNameText":self.lastNameText, @"confirmButton":self.confirmButton};
  
  NSArray *firstNameTextVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-120-[firstNameText]" options:0 metrics:nil views:views];
  [self.rootView addConstraints: firstNameTextVertical];
  
  NSArray *lastNameTextVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameText]-60-[lastNameText]" options:0 metrics:nil views:views];
  [self.rootView addConstraints: lastNameTextVertical];
  
  NSArray *confirmButtonVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameText]-60-[confirmButton]" options:0 metrics:nil views:views];
  [self.rootView addConstraints: confirmButtonVertical];
  
  [self.confirmButton addTarget:self action: @selector(confirmReservation:) forControlEvents:UIControlEventTouchUpInside];
  
  
  self.view = self.rootView;
    // Do any additional setup after loading the view.
}

-(void)viewDidLoad{
  [super viewDidLoad];
}


-(void)confirmReservation:(id)sender{
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName: @"Reservation" inManagedObjectContext:appDelegate.managedObjectContext];
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:appDelegate.managedObjectContext];
  
  guest.firstName = self.firstNameText.text;
  guest.lastName = self.lastNameText.text;
  
  
  
  reservation.startDate = self.startDate;
  reservation.endDate = self.endDate;
  reservation.guest = guest;
  reservation.room = self.room;
  
//  NSLog(@"%@",reservation.guest);
//  NSLog(@"%@",reservation.room);
//  NSLog(@"%@",reservation.startDate);
//  NSLog(@"%@",reservation.endDate);

  
  NSError *error = nil;
  [appDelegate.managedObjectContext save:&error];
  
  [self.navigationController popToRootViewControllerAnimated:true];
  
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
