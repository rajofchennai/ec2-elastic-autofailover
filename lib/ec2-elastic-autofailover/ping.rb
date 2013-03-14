module AutoFailover
  def ping_url
    begin
      RestClient::Request.execute(:method => :get, :url => url, :timeout => 5, :open_timeout => 5)
    rescue Errno::ECONNREFUSED => xcp
      nil
    rescue RestClient::ResourceNotFound => xcp
      nil
    rescue Errno::ETIMEDOUT => xcp
      nil
    end
  end

  def url
    "#{@protocol}://#{@url}"
  end
end
