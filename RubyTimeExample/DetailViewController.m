//
//  DetailViewController.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "Activity.h"
#import "DetailViewController.h"
#import "ServerConnector.h"

@implementation DetailViewController

LLReleaseOnDealloc(project, activities);

- (id) initWithProject: (Project *) aProject {
  self = [super initWithNibName: @"TableView" bundle: nil];
  if (self) {
    project = [aProject retain];
    self.title = [project name];
  }
  return self;
}

- (void) viewWillAppear: (BOOL) animated {
  [super viewWillAppear: animated];

  // load data from the server when the view is displayed
  LLRequest *request = [[ServerConnector sharedConnector] loadActivitiesRequestForProject: project];
  [request sendFor: self callback: @selector(activitiesLoaded:)];
}

// UITableView delegate and data source methods that describe table's contents and behavior

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
  return activities.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
  Activity *activity = [activities objectAtIndex: indexPath.row];

  UITableViewCell *cell = [tableView llGenericCellWithStyle: UITableViewCellStyleSubtitle];
  cell.accessoryType = UITableViewCellAccessoryNone;
  cell.textLabel.text = [activity comments];
  cell.detailTextLabel.text = LLFormat(@"%@ - %@", activity.date, [activity minutesAsString]);
  return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
  [tableView deselectRowAtIndexPath: indexPath animated: YES];
}

// PSConnector response callbacks

- (void) activitiesLoaded: (NSArray *) list {
  activities = [list retain];
  [self.tableView reloadData];
}

- (void) requestFailed: (LLRequest *) request withError: (NSError *) error {
  [UIAlertView llShowErrorWithMessage: LLFormat(@"Connection error: %@", error)];
}

- (void) authenticationFailedInRequest: (LLRequest *) request {
  [UIAlertView llShowErrorWithMessage: @"Invalid login or password."];
}
							
@end
