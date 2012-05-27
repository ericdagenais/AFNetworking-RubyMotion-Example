class TwitterApiClient < AFHTTPClient
  @@instance = nil

  def self.instance
    return @@instance unless @@instance.nil?
    @@instance = TwitterApiClient.alloc.initWithBaseURL(NSURL.URLWithString("http://api.twitter.com/"))
    @@instance.registerHTTPOperationClass(AFJSONRequestOperation)
    @@instance.setDefaultHeader("Accept", value:"application/json")
    @@instance
  end

  def getPublicTimeline(&callback)
    getPath("1/statuses/public_timeline.json",
      parameters:{},
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
