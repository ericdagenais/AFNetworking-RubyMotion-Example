class MyTableViewController < UITableViewController
  def viewDidLoad
    @json = []
    @pullToRefreshView = SSPullToRefreshView.alloc.initWithScrollView(self.tableView, delegate:self)
    loadData
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @json.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("test") || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:"test")
    cell.textLabel.text =  @json[indexPath.row]['text']
    cell.detailTextLabel.text = @json[indexPath.row]['user']['name']
    cell
  end

  def loadData
    @pullToRefreshView.startLoading
    url = NSURL.URLWithString("http://api.twitter.com/1/statuses/public_timeline.json")
    request = NSURLRequest.requestWithURL(url)
    NSLog("%@", url)
    AFJSONRequestOperation.JSONRequestOperationWithRequest(request, success:lambda {
      |request, response, json|
      @json = json
      self.view.reloadData
      @pullToRefreshView.finishLoading
    }, failure:lambda {
      |request, response, error, json|
      @pullToRefreshView.finishLoading
      NSLog("error [%@]: %@", request.URL, error)
    }).start
  end

  def pullToRefreshViewDidStartLoading(view)
    self.loadData
  end
end
