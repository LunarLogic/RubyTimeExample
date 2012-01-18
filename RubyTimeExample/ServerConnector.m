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

- (void) prepareRequest: (LLRequest *) request {
  [request setAuthenticationScheme: (NSString *) kCFHTTPAuthenticationSchemeBasic];
}

// methods that generate requests

- (LLRequest *) loginRequest {
  return [super requestToPath: @"/users/authenticate"];
}

- (LLRequest *) loadProjectsRequest {
  LLRequest *request = [super requestToPath: @"/projects"];
  request.successHandler = @selector(projectsLoaded:);
  return request;
}

- (LLRequest *) loadActivitiesRequestForProject: (Project *) project {
  NSString *path = LLFormat(@"/projects/%@/activities?search_criteria[limit]=30", project.recordId);
  LLRequest *request = [super requestToPath: path];
  request.successHandler = @selector(activitiesForProjectLoaded:);
  return request;
}

// methods that handle responses

- (void) projectsLoaded: (LLRequest *) request {
  // use JSONKit to parse response into NSDictionary objects and then build Project model instances
  NSArray *projects = [self parseObjectsFromRequest: request model: [Project class]];

  // call the method that the caller specified in "sendFor:callback:"
  [request notifyTargetOfSuccessWithObject: projects];
}

- (void) activitiesForProjectLoaded: (LLRequest *) request {
  // use JSONKit to parse response into NSDictionary objects and then build Activity model instances
  NSArray *activities = [self parseObjectsFromRequest: request model: [Activity class]];

  // call the method that the caller specified in "sendFor:callback:"
  [request notifyTargetOfSuccessWithObject: activities];
}

@end
