# RubyTime example

This is an example application created in order to show how you can write a simple iOS app that connects to an external API and displays downloaded JSON data. It connects to a demo installation of [RubyTime](http://rubytime.org), our time tracking system, and displays a list of projects and each project's activities.

## License

Copyright by Jakub Suder <jakub.suder at gmail.com> & Lunar Logic Polska. Licensed under [WTFPL license](http://sam.zoy.org/wtfpl/).

This app uses [ASIHTTPRequest by Ben Copsey](https://github.com/pokeb/asi-http-request) for making network connections, [JSONKit by John Engelhart](https://github.com/johnezang/JSONKit) for JSON parsing, [SFHFKeychainUtils by Buzz Andersen](https://github.com/ldandersen/scifihifi-iphone/tree/master/security) to store user's credentials, and my own library [PsiToolkit](https://github.com/psionides/PsiToolkit) to make various things easier.
