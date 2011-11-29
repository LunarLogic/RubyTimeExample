//
//  ServerConnector.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "Activity.h"
#import "Project.h"
#import "ServerConnector.h"

@implementation ServerConnector

- (id) init {
  self = [super init];
  if (self) {
    self.usesHTTPAuthentication = YES;
    self.baseURL = @"http://demo.rubytime.org";
  }
  return self;
}

- (void) prepareRequest: (PSRequest *) request {
  [request setAuthenticationScheme: (NSString *) kCFHTTPAuthenticationSchemeBasic];
}

- (PSRequest *) loginRequest {
  return [super requestToPath: @"/users/authenticate"];
}

- (PSRequest *) loadProjectsRequest {
  PSRequest *request = [super requestToPath: @"/projects"];
  request.successHandler = @selector(projectsLoaded:);
  return request;
}

- (PSRequest *) loadActivitiesRequestForProject: (Project *) project {
  NSString *path = PSFormat(@"/projects/%@/activities?search_criteria[limit]=30", project.recordId);
  PSRequest *request = [super requestToPath: path];
  request.successHandler = @selector(activitiesForProjectLoaded:);
  return request;
}

- (void) projectsLoaded: (PSRequest *) request {
  NSArray *projects = [self parseObjectsFromRequest: request model: [Project class]];
  [request notifyTargetOfSuccessWithObject: projects];
}

- (void) activitiesForProjectLoaded: (PSRequest *) request {
  NSArray *activities = [self parseObjectsFromRequest: request model: [Activity class]];
  [request notifyTargetOfSuccessWithObject: activities];
}

@end
