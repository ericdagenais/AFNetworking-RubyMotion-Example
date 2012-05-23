class MyTableViewController < UITableViewController
  def viewDidLoad
    @json = []
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
    request = NSURLRequest.requestWithURL NSURL.URLWithString("http://api.twitter.com/1/statuses/public_timeline.json")
    AFJSONRequestOperation.JSONRequestOperationWithRequest(request, success:lambda {
      |request, response, json|
      @json = json
      self.view.reloadData
    }, failure:lambda {
      |request, response, error, json|
      NSLog("error [%@]: %@", request.URL, error)
    }).start
  end
end
