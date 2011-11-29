//
//  MasterViewController.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Project.h"
#import "ServerConnector.h"

@implementation MasterViewController

- (id) init {
  self = [super initWithNibName: @"TableView" bundle: nil];
  if (self) {
    self.title = @"Projects";
  }
  return self;
}

- (void) viewWillAppear: (BOOL) animated {
  [super viewWillAppear: animated];

  // load data from the server when the view is displayed
  if (!projects && [[ServerConnector sharedConnector] account]) {
    [[[ServerConnector sharedConnector] loadProjectsRequest] sendFor: self callback: @selector(projectsLoaded:)];
  }
}

// UITableView delegate and data source methods that describe table's contents and behavior

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
  return projects.count;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
  UITableViewCell *cell = [tableView psGenericCellWithStyle: UITableViewCellStyleDefault];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text = [[projects objectAtIndex: indexPath.row] name];
  return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
  Project *project = [projects objectAtIndex: indexPath.row];

  DetailViewController *subcontroller = [[DetailViewController alloc] initWithProject: project];
  [self.navigationController pushViewController: [subcontroller autorelease] animated: YES];
}

// PSConnector response callbacks

- (void) projectsLoaded: (NSArray *) list {
  projects = [list retain];
  [self.tableView reloadData];
}

- (void) requestFailed: (PSRequest *) request withError: (NSError *) error {
  [UIAlertView psShowErrorWithMessage: PSFormat(@"Connection error: %@", error)];
}

- (void) authenticationFailedInRequest: (PSRequest *) request {
  [UIAlertView psShowErrorWithMessage: @"Invalid login or password."];
}

@end
