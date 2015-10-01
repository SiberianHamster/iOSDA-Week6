//
//  ReservationViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/10/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "ReservationViewController.h"
#import "ResultsViewController.h"


@interface ReservationViewController ()<UITraitEnvironment>

@property (nonatomic, retain) ResultsViewController *ResultsViewController;
@property (strong, nonatomic) UIDatePicker *startDate;
@property (strong, nonatomic) UIDatePicker *endDate;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UILabel *startLabel;
@property (strong, nonatomic) UILabel *endLabel;
@property (strong, nonatomic) NSArray *startLabelTop;
@property (strong, nonatomic) NSArray *horizantalStartLabelTop;
@property (strong, nonatomic) NSDictionary *views;
@property (strong, nonatomic) UIView *rootView ;
@property (strong,nonatomic) NSDateFormatter *startDateFormatter;
@property (strong,nonatomic) NSDateFormatter *endDateFormatter;
@property (strong, nonatomic)   NSDate *todayDate;


//@property (nonatomic, readwrite) UITraitCollection *traitCollection;

@end

@implementation ReservationViewController
@dynamic traitCollection;

-(void)loadView{
  self.rootView = [[UIView alloc]init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.startDate = [[UIDatePicker alloc]init];
  self.endDate = [[UIDatePicker alloc]init];
  self.selectButton = [[UIButton alloc]init];
  self.selectButton.backgroundColor = [UIColor blueColor];
  [self.selectButton setTitle:@"Search" forState: UIControlStateNormal];
  self.endLabel = [[UILabel alloc]init];
  self.startLabel = [[UILabel alloc]init];
  self.startLabel.backgroundColor = [UIColor whiteColor];
  self.endLabel.backgroundColor = [UIColor whiteColor];
  [self.startLabel setText:@"Select a start date"];
  [self.endLabel setText:@"Select an end date"];
  
  [self.rootView addSubview: self.startDate];
  [self.rootView addSubview: self.endDate];
  [self.rootView addSubview: self.selectButton];
  [self.rootView addSubview: self.startLabel];
  [self.rootView addSubview: self.endLabel];
  
  [self.selectButton addTarget:self action:@selector(goToReservation:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.startDate setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.endDate setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.selectButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.startLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.endLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.views = @{@"startDate" : self.startDate, @"endDate" : self.endDate, @"selectButton" : self.selectButton, @"startLabel":self.startLabel, @"endLabel":self.endLabel};
  
  self.startLabelTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[startLabel]" options:0 metrics:nil views:self.views];
  [self.rootView addConstraints: self.startLabelTop];
  
  NSLayoutConstraint *startLabelCenterX = [NSLayoutConstraint constraintWithItem:self.startLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint: startLabelCenterX];
  
  NSArray *endLabelTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDate]-32-[endLabel]" options:0 metrics:nil views:self.views];
  [self.rootView addConstraints: endLabelTop];
  
  NSLayoutConstraint *endLabelCenterX = [NSLayoutConstraint constraintWithItem:self.endLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint: endLabelCenterX];
  
  NSArray *selectButtonBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[selectButton]-8-|" options:0 metrics:nil views:self.views];
  [self.rootView addConstraints:selectButtonBottom];
  
  NSLayoutConstraint *selectButtonCenterX = [NSLayoutConstraint constraintWithItem:self.selectButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint:selectButtonCenterX];
  
  NSArray *startDatePickerVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startLabel]-8-[startDate]" options:0 metrics:nil views:self.views];
  [self.rootView addConstraints:startDatePickerVertical];
  
  NSLayoutConstraint *startDatePickerCenterX = [NSLayoutConstraint constraintWithItem:self.startDate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint: startDatePickerCenterX];
  
  NSArray *endDatePickerVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[endLabel]-8-[endDate]" options:0 metrics:nil views:self.views];
  [self.rootView addConstraints:endDatePickerVertical];
  
  NSLayoutConstraint *endDatePickerCenterX = [NSLayoutConstraint constraintWithItem:self.endDate attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [self.rootView addConstraint: endDatePickerCenterX];
  
  [self.startDate addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  
  

  
  self.view = self.rootView;
}




-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
  [super traitCollectionDidChange:previousTraitCollection];
  if ((self.traitCollection.verticalSizeClass!=previousTraitCollection.verticalSizeClass || self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass)) {
    
//    
//    self.horizantalStartLabelTop = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-72-[startLabel]" options:0 metrics:nil views:self.views];
//    [self.rootView addConstraints: self.horizantalStartLabelTop];
//    
//

    
  }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.todayDate = self.currentLocalDate;
  self.startDate.minimumDate = self.todayDate;
  self.endDate.minimumDate = [self.todayDate dateByAddingTimeInterval:60*60*24];
  self.endDate.datePickerMode = UIDatePickerModeDate;
  self.endDateFormatter = [[NSDateFormatter alloc]init];
  self.startDate.datePickerMode = UIDatePickerModeDate;
  self.startDateFormatter = [[NSDateFormatter alloc] init];
  
//    NSLog(@"hi end date is: %@",self.endDate.date);
  
    // Do any additional setup after loading the view.
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)datePickerValueChanged:(UIDatePicker *)sender {
  
  [self.startDateFormatter setDateFormat:@"MMMM dd yyyy"];
  [self.endDateFormatter setDateFormat:@"MMMM dd yyyy"];
}

-(NSDate *)currentLocalDate{
  
  // got the base code from http://stackoverflow.com/questions/15615637/how-to-get-local-time-on-ios
  
  NSDate *sourceDate = [NSDate date];
  
  NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
  NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
  
  NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
  NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
  NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
  
  NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
  return destinationDate;
}


-(void)goToReservation:(id)sender{

  NSLog(@"today:%@", self.todayDate);
  
  if (self.endDate.date <= self.startDate.date) {
    NSLog(@"DATE ERROR: self.endDate.date <= self.startDate.date");
  }
  
  if (self.startDate.date < self.todayDate) {
    NSLog(@"DATE ERROR:self.startDate.date < self.todayDate");
  }
  
  if ((self.endDate.date > self.startDate.date) && (self.startDate.date >= self.todayDate)){
        ResultsViewController *resultsViewController = [[ResultsViewController alloc]init];
    NSLog(@"Sending start:%@",self.startDate.date);
    NSLog(@"Sending end:%@",self.endDate.date);
    resultsViewController.endDate = self.endDate.date;
    resultsViewController.startDate = self.startDate.date;
    
    
    [self.navigationController pushViewController:resultsViewController animated:true];

  }else{
    //alert user
    NSLog(@"Bad Entry");
    
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

@end
