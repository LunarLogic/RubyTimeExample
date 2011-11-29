//
//  ServerConnector.h
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "PSConnector.h"

@class Project;

@interface ServerConnector : PSConnector

- (PSRequest *) loginRequest;
- (PSRequest *) loadProjectsRequest;
- (PSRequest *) loadActivitiesRequestForProject: (Project *) project;

@end
