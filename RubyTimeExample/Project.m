//
//  Project.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize name;
LLReleaseOnDealloc(name);

+ (NSArray *) propertyList {
  return LLArray(@"name");
}

@end
