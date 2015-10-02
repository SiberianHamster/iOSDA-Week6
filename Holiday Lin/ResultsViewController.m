//
//  ResultsViewController.m
//  Holiday Lin
//
//  Created by Mark Lin on 9/11/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "ResultsViewController.h"
#import "AppDelegate.h"
#import "Room.h"
#import "ConfirmReservationViewController.h"
#import "Reservation.h"

@interface ResultsViewController()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)Room *listrooms;
@property (strong, nonatomic)Room *room;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSArray *filteredArray;

@end


@implementation ResultsViewController
//@synthesize fetchedResultsController = _fetchedResultsController;


#pragma mark - LoadView
-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc]init];
  self.tableView.backgroundColor = [UIColor whiteColor];
  [rootView addSubview:self.tableView];
  
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  NSDictionary *views = @{@"tableView":self.tableView};
  
  NSArray *tableViewHorizantal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizantal];
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  self.view = rootView;
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  NSLog(@"startDate in res: %@", self.startDate);
  NSLog(@"endDate in res: %@", self.endDate);
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  _managedObjectContext = appDelegate.managedObjectContext;
  
  [self fetchedResultsController];
  
  //  NSError *error;
  //  if (![[self fetchedResultsController] performFetch:&error]) {
  //    NSLog(@"There was an error: %@, %@", error, [error userInfo]);
  //    exit(-1);
  //  }
  // Do any additional setup after loading the view.
}

#pragma -fetchedResultsController
- (NSArray *)fetchedResultsController {
  
//  if (_fetchedResultsController != nil) {
//    return _fetchedResultsController;
//  }
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",self.endDate,self.startDate];
  
  request.predicate = predicate;
  
  NSError *fetchError;
  NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc]init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [appDelegate.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if (finalError) {
    return nil;
  }
  return finalResults;
}
  
  
  
//  self.fetchRequest = [[NSFetchRequest alloc] init];
//  NSEntityDescription *entity = [NSEntityDescription
//                                 entityForName:@"Room" inManagedObjectContext: _managedObjectContext];
//  [self.fetchRequest setEntity:entity];
//  
//  NSSortDescriptor *sort = [[NSSortDescriptor alloc]
//                            initWithKey:@"number" ascending:NO];
//  [self.fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
//  
//  [self.fetchRequest setFetchBatchSize:20];
//  
//  NSFetchedResultsController *theFetchedResultsController =
//  [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
//                                      managedObjectContext:_managedObjectContext sectionNameKeyPath:nil
//                                                 cacheName:@"date"];
//  self.fetchedResultsController = theFetchedResultsController;
//  _fetchedResultsController.delegate = self;
//  
//  return _fetchedResultsController;



- (void)viewDidUnload {
  self.fetchedResultsController = nil;
}

#pragma mark -TableView
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  id  sectionInfo =
  [[_fetchedResultsController sections] objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  self.room = [_fetchedResultsController objectAtIndexPath:indexPath];
  NSString* myNewString = [NSString stringWithFormat:@"%@", self.room.number];
  cell.textLabel.text = myNewString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell =
  [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  [self configureCell:cell atIndexPath:indexPath];
  
  return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
  [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  UITableView *tableView = self.tableView;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      
    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:[NSArray
                                         arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:[NSArray
                                         arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  ConfirmReservationViewController *confirmReservationViewController = [[ConfirmReservationViewController alloc]init];
  self.room = [_fetchedResultsController objectAtIndexPath:indexPath];
  confirmReservationViewController.room = self.room;
  confirmReservationViewController.startDate = self.startDate;
  confirmReservationViewController.endDate = self.endDate;
  
  [self.navigationController pushViewController:confirmReservationViewController animated:true];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
  [self.tableView endUpdates];
}

@end
