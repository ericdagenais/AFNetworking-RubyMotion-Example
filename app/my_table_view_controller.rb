class MyTableViewController < UITableViewController
  def viewDidLoad
    @data = []
    @pullToRefreshView = SSPullToRefreshView.alloc.initWithScrollView(self.tableView, delegate:self)
    loadData
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @data.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("test") || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:"test")
    cell.textLabel.text =  @data[indexPath.row]['text']
    cell.detailTextLabel.text = @data[indexPath.row]['from_user_name']
    cell
  end

  def loadData
    TwitterApiClient.instance.getPublicTimeline do |response|
      @data = response['results'] unless response.nil?
      self.view.reloadData
    end
  end

  def pullToRefreshViewDidStartLoading(view)
    @pullToRefreshView.startLoading
    self.loadData
    @pullToRefreshView.finishLoading
  end
end
