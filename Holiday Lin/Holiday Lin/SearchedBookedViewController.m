//
//  SearchedBookedViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 10/2/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "SearchedBookedViewController.h"
#import "AppDelegate.h"
#import "Guest.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"

@interface SearchedBookedViewController ()

@property (strong, nonatomic)UITextField *lastNameText;
@property (strong, nonatomic)UIButton *searchButton;
@property (strong, nonatomic)UIView *rootView;
@property (strong, nonatomic)UITextView *resultsTextView;
@property (strong, nonatomic)NSString *reportResult;

@end

@implementation SearchedBookedViewController
-(void)loadView{
  self.rootView = [[UIView alloc]init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  

  self.lastNameText = [[UITextField alloc]init];
  self.searchButton = [[UIButton alloc]init];
  self.resultsTextView = [[UITextView alloc]init];
  
  [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
  self.lastNameText.placeholder = @"Last Name";

  [self.lastNameText setTextColor:[UIColor redColor]];
  [self.searchButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.resultsTextView setTextColor:[UIColor redColor]];
  
  
  [self.rootView addSubview:self.lastNameText];
  [self.rootView addSubview:self.searchButton];
  [self.rootView addSubview:self.resultsTextView];
  
  [self.lastNameText setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.searchButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.resultsTextView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  
  NSLayoutConstraint *lastNameLabelHorizantal = [NSLayoutConstraint constraintWithItem:self.lastNameText attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:lastNameLabelHorizantal];
  
  NSLayoutConstraint *buttonHorizantal = [NSLayoutConstraint constraintWithItem:self.searchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:buttonHorizantal];
  
  NSLayoutConstraint *resultTextHorizantal = [NSLayoutConstraint constraintWithItem:self.resultsTextView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:resultTextHorizantal];
  
  NSDictionary *views = [[NSDictionary alloc]init];
  views = @{@"lastNameText":self.lastNameText, @"searchButton":self.searchButton, @"textResult":self.resultsTextView};
  
  NSArray *lastNameTextVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-160-[lastNameText]" options:0 metrics:nil views:views];
  [self.rootView addConstraints: lastNameTextVertical];
  
  NSArray *confirmButtonVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameText]-60-[searchButton]" options:0 metrics:nil views:views];
  [self.rootView addConstraints: confirmButtonVertical];
  
  NSArray *resultsTextfieldVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchButton]-60-[textResult]-|" options:0 metrics:nil views:views];
  [self.rootView addConstraints: resultsTextfieldVertical];
  
  NSArray *resultsTextViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textResult]-|" options:0 metrics:nil views:views];
  [self.rootView addConstraints:resultsTextViewHorizontal];
  
  
  [self.searchButton addTarget:self action: @selector(searchResults:) forControlEvents:UIControlEventTouchUpInside];

  
  
  
  
  
  self.view = self.rootView;
}

-(void)searchResults:(id)sender{

  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];

  NSError *fetchError;
  NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  
  for (Reservation *reservation in results) {
    if ([reservation.guest.lastName isEqualToString:self.lastNameText.text]) {
     
      if (!self.reportResult) {
        self.reportResult = [NSString stringWithFormat: @"Hi %@, your reservation is between %@ and %@ in room %@ of hotel %@", reservation.guest.firstName, reservation.startDate, reservation.endDate, reservation.room.number, reservation.room.hotel.name];
      } else{
        NSString *appendResult = [NSString stringWithFormat: @"Hi %@, your reservation is between %@ and %@ in room %@ of hotel %@", reservation.guest.firstName, reservation.startDate, reservation.endDate, reservation.room.number, reservation.room.hotel.name];
        [self.reportResult stringByAppendingString:(appendResult)];
        NSLog(@"%@",appendResult);
      }
      
    }
    
  }
  [self.resultsTextView setText: (self.reportResult)];
  self.reportResult = nil;

}

//  Reservation *firstReservation = guest.reservation;
//  Room *room = firstReservation.room;
//  Hotel *hotel = room.hotel;
  
//  NSString *string1 = [NSString stringWithFormat: @"Hi %@, your reservation is between %@ and %@ in room %@ of hotel %@", guest.firstName, firstReservation.startDate, firstReservation.endDate, room.number, hotel.name];
//  NSLog(@"stuff %@", string1);
  
//}

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
