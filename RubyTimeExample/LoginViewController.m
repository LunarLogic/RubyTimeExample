//
//  LoginViewController.m
//  RubyTimeExample
//
//  Created by Jakub Suder on 11.28.11.
//  Copyright (c) 2011 Lunar Logic Polska. All rights reserved.
//

#import "LoginViewController.h"
#import "ServerConnector.h"

@interface LoginViewController ()
- (void) authenticate;
@end

@implementation LoginViewController

@synthesize usernameField, passwordField, loginButton, spinner;
PSReleaseOnDealloc(usernameField, passwordField, loginButton, spinner);

- (id) init {
  return [super initWithNibName: @"LoginViewController" bundle: nil];
}

- (void) viewDidLoad {
  [super viewDidLoad];

  // focus the username field at the beginning
  [usernameField becomeFirstResponder];
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
  // if user clicks "next" or "go" on the keyboard, move to the next step if the field isn't empty

  if (textField == usernameField && usernameField.text.length > 0) {
    [passwordField becomeFirstResponder];
    return YES;
  } else if (textField == passwordField && passwordField.text.length > 0) {
    [self authenticate];
    return YES;
  }

  return NO;
}

- (IBAction) loginPressed {
  [self authenticate];
}

- (void) authenticate {
  PSAccount *account = [[PSAccount alloc] init];
  account.username = usernameField.text;
  account.password = passwordField.text;

  ServerConnector *connector = [ServerConnector sharedConnector];
  connector.account = [account autorelease];

  [spinner startAnimating];
  [loginButton setEnabled: NO];
  [[connector loginRequest] sendFor: self callback: @selector(loginSuccessful)];
}

- (void) enableForm {
  [spinner stopAnimating];
  [loginButton setEnabled: YES];
}

// PSConnector response callbacks

- (void) loginSuccessful {
  [[[ServerConnector sharedConnector] account] save];
  [self dismissModalViewControllerAnimated: YES];
}

- (void) requestFailed: (PSRequest *) request withError: (NSError *) error {
  [self enableForm];
  [UIAlertView psShowErrorWithMessage: PSFormat(@"Connection error: %@", error)];
}

- (void) authenticationFailedInRequest: (PSRequest *) request {
  [self enableForm];
  [UIAlertView psShowErrorWithMessage: @"Invalid login or password."];
}

@end
