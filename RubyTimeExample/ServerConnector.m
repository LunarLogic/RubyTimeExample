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
    // if this is set, PSConnector sends its account's username & password as HTTP Basic authentication
    self.usesHTTPAuthentication = YES;

    // this is used as a base for all request URLs
    self.baseURL = @"http://demo.rubytime.org";
  }
  return self;
}

- (void) prepareRequest: (PSRequest *) request {
  [request setAuthenticationScheme: (NSString *) kCFHTTPAuthenticationSchemeBasic];
}

// methods that generate requests

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

// methods that handle responses

- (void) projectsLoaded: (PSRequest *) request {
  // use JSONKit to parse response into NSDictionary objects and then build Project model instances
  NSArray *projects = [self parseObjectsFromRequest: request model: [Project class]];

  // call the method that the caller specified in "sendFor:callback:"
  [request notifyTargetOfSuccessWithObject: projects];
}

- (void) activitiesForProjectLoaded: (PSRequest *) request {
  // use JSONKit to parse response into NSDictionary objects and then build Activity model instances
  NSArray *activities = [self parseObjectsFromRequest: request model: [Activity class]];

  // call the method that the caller specified in "sendFor:callback:"
  [request notifyTargetOfSuccessWithObject: activities];
}

@end
