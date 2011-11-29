//
//  AppDelegate.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MasterViewController.h"
#import "ServerConnector.h"

@implementation AppDelegate

@synthesize window, navigationController;
PSReleaseOnDealloc(window, navigationController);

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  UIWindow *mainWindow = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
  self.window = [mainWindow autorelease];

  ServerConnector *connector = [[ServerConnector alloc] init];
  [ServerConnector setSharedConnector: [connector autorelease]];
  connector.account = [PSAccount accountFromSettings];

  MasterViewController *masterViewController = [[[MasterViewController alloc] init] autorelease];
  self.navigationController = [masterViewController psWrapInNavigationController];

  mainWindow.rootViewController = self.navigationController;
  [mainWindow makeKeyAndVisible];

  if (!connector.account) {
    LoginViewController *loginView = [[[LoginViewController alloc] init] autorelease];
    [masterViewController presentModalViewController: loginView animated: YES];
  }

  return YES;
}

@end
