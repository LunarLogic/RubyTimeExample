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

PSReleaseOnDealloc(project, activities);

- (id) initWithProject: (Project *) aProject {
  self = [super initWithNibName: @"TableView" bundle: nil];
  if (self) {
    project = [aProject retain];
    self.title = [project name];
  }
  return self;
}

- (void) viewWillAppear: (BOOL) animated {
  PSRequest *request = [[ServerConnector sharedConnector] loadActivitiesRequestForProject: project];
  [request sendFor: self callback: @selector(activitiesLoaded:)];
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
  return activities.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
  Activity *activity = [activities objectAtIndex: indexPath.row];

  UITableViewCell *cell = [tableView psGenericCellWithStyle: UITableViewCellStyleSubtitle];
  cell.accessoryType = UITableViewCellAccessoryNone;
  cell.textLabel.text = [activity comments];
  cell.detailTextLabel.text = PSFormat(@"%@ - %@", activity.date, [activity minutesAsString]);
  return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
  [tableView deselectRowAtIndexPath: indexPath animated: YES];
}

- (void) activitiesLoaded: (NSArray *) list {
  activities = [list retain];
  [self.tableView reloadData];
}

- (void) requestFailed: (PSRequest *) request withError: (NSError *) error {
  [UIAlertView psShowErrorWithMessage: PSFormat(@"Connection error: %@", error)];
}

- (void) authenticationFailedInRequest: (PSRequest *) request {
  [UIAlertView psShowErrorWithMessage: @"Invalid login or password."];
}
							
@end
