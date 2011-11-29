//
//  Activity.h
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "PSModel.h"

@interface Activity : PSModel

@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger minutes;

- (NSString *) minutesAsString;

@end
