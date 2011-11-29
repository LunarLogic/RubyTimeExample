# RubyTime example

This is an example application created in order to show how you can write a simple iOS app that connects to an external API and displays downloaded JSON data. It connects to a demo installation of [RubyTime](http://rubytime.org), our time tracking system, and displays a list of projects and each project's activities.

<a href="https://github.com/LunarLogicPolska/RubyTimeExample/raw/master/screenshot.png"><img src="https://github.com/LunarLogicPolska/RubyTimeExample/raw/master/screenshot.png" width="250"></a>

## Contents

* [AppDelegate](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/AppDelegate.m) – the entry point to the app; creates a window, main view controller, shows a login form popup
* [LoginViewController](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/LoginViewController.m) – asks the user for username and password and then sends them to the server to check if they're correct
* [MasterViewController](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/MasterViewController.m) – loads all projects from the API and displays them on the list
* [DetailViewController](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/DetailViewController.m) – loads a selected project's activities from the API and displays them
* [ServerConnector](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/ServerConnector.m) – a shared singleton object that handles all connections to the API and returns data to view controllers
* [Activity](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/Activity.m), [Project](https://github.com/LunarLogicPolska/RubyTimeExample/blob/master/RubyTimeExample/Project.m) – model objects built from JSON hashes downloaded from the API

Some non-standard things you might see that come from [PsiToolkit](https://github.com/psionides/PsiToolkit) (basically anything that starts with "PS" comes from there):

* PSArray – this is a macro that saves you some typing while creating an array
* PSFormat – a macro which simplifies creating strings, works just like `printf`
* PSReleaseOnDealloc – a macro that lets you write a dealloc method that releases 4 objects in 1 line instead of 7
* PSAccount – lets you store a username and password, save them into settings and load them back
* PSConnector – simplifies building network connection classes like ServerConnector
* psWrapInNavigationController – returns a new UINavigationController having given controller at the root of the stack
* psShowErrorWithMessage – show a UIAlertView with title "Error" and given message

## License

Copyright by Jakub Suder <jakub.suder at gmail.com> & Lunar Logic Polska. Licensed under [WTFPL license](http://sam.zoy.org/wtfpl/).

This app uses [ASIHTTPRequest by Ben Copsey](https://github.com/pokeb/asi-http-request) for making network connections, [JSONKit by John Engelhart](https://github.com/johnezang/JSONKit) for JSON parsing, [SFHFKeychainUtils by Buzz Andersen](https://github.com/ldandersen/scifihifi-iphone/tree/master/security) to store user's credentials, and my own library [PsiToolkit](https://github.com/psionides/PsiToolkit) to make various things easier.
