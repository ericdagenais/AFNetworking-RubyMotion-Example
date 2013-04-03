# An AFNetworking RubyMotion iOS Example

An example to demonstrate the use of [AFNetworking][AF] with [RubyMotion][RM].

### Quickstart

        git clone https://github.com/ericdagenais/AFNetworking-RubyMotion-Example.git
        cd AFNetworking-RubyMotion-Example

Install both the 'cocoapods' and 'motion-cocoapods' gems via bundler (see this [article][CP] for more info). Gemfile installs specific versions to workaround an [incompatibility][BB] with the latest Cocoapods gem.

        # gem install bundler  # install bundler if you don't have it already
        bundle install

Run the example

        rake

### Caveats

#### `nil` Callback Blocks

The Objective-C examples for AFNetworking often pass in `nil` as callback blocks. In RubyMotion, passing in nil to these callbacks causes a crash if the callback ever needs to be called. To avoid crashing, pass in an empty proc *with the correct number of parameters*.

For example, passing in `nil` to `failure:` below works in Objective-C but will cause a crash in RubyMotion if the request fails:

``` objective-c
NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
NSURLRequest *request = [NSURLRequest requestWithURL:url];
AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    NSLog(@"Public Timeline: %@", JSON);
} failure:nil];
[operation start];
```

Therefore, the above should be written as the following to avoid problems:

``` ruby
url = NSURL.URLWithString("http://api.twitter.com/1/statuses/public_timeline.json")
request = NSURLRequest.requestWithURL(url)
operation = AFJSONRequestOperation.JSONRequestOperationWithRequest(request, success:lambda {
  |request, response, json|
  NSLog("Public Timeline: %@", json)
}, failure:lambda {
  |request, response, error, json| # correct number of parameters is important
})
operation.start
```

[Groups discussion][GG]

### Dependencies

* XCode 4.x w/ iOS SDK 5.x
* RubyMotion
* CocoaPods

Interested in RestKit instead of AFNetworking? Checkout [RestKitTest][RKT].

[AF]: https://github.com/AFNetworking/AFNetworking
[RM]: http://www.rubymotion.com/
[CP]: http://www.rubymotion.com/developer-center/articles/cocoapods/
[RKT]: https://github.com/rounders/RestKitTest
[GG]: https://groups.google.com/forum/#!topic/rubymotion/rYpwQKyCzRQ
[BB]: https://github.com/HipByte/motion-cocoapods/issues/51
