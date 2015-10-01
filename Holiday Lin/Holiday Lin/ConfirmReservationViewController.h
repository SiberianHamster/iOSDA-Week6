//
//  ConfirmReservationViewController.h
//  Holiday Lin
//
//  Created by Mark Lin on 10/1/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ConfirmReservationViewController : UIViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) NSDate *endDate;

@end
