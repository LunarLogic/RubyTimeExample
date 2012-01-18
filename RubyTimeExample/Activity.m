//
//  Activity.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "Activity.h"

@implementation Activity

@synthesize comments, date, minutes;
LLReleaseOnDealloc(comments, date);

+ (NSArray *) propertyList {
  return LLArray(@"comments", @"date", @"minutes");
}

- (NSString *) minutesAsString {
  return LLFormat(@"%d:%02d", minutes / 60, minutes % 60);
}

@end
