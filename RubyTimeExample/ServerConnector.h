//
//  ServerConnector.h
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "LLConnector.h"

@class Project;

@interface ServerConnector : LLConnector

- (LLRequest *) loginRequest;
- (LLRequest *) loadProjectsRequest;
- (LLRequest *) loadActivitiesRequestForProject: (Project *) project;

@end
