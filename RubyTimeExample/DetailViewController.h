//
//  DetailViewController.h
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface DetailViewController : UITableViewController {
  NSArray *activities;
  Project *project;
}

- (id) initWithProject: (Project *) project;

@end
