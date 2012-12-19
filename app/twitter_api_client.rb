class TwitterApiClient < AFHTTPClient
  @@instance = nil

  def self.instance
    return @@instance unless @@instance.nil?
    @@instance = TwitterApiClient.alloc.initWithBaseURL(NSURL.URLWithString("http://search.twitter.com/"))
    @@instance.registerHTTPOperationClass(AFJSONRequestOperation)
    @@instance.setDefaultHeader("Accept", value:"application/json")
    @@instance
  end

  def getPublicTimeline(&callback)
    getPath("search.json",
      parameters:{:q => "@noradio"},
      success:lambda { |operation, response|
        callback.call(response)
      },
      failure:lambda { |operation, error|
        NSLog("error[%@] => %@", error.userInfo[NSURLErrorFailingURLErrorKey], error.localizedDescription)
        callback.call(nil)
      }
    )
  end
end
