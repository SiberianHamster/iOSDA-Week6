//
//  ResultsViewController.h
//  Holiday Lin
//
//  Created by Mark Lin on 9/11/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ResultsViewController : UITableViewController

@property(strong, nonatomic)NSDate *startDate;
@property(strong, nonatomic)NSDate *endDate;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end
