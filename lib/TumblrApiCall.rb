class TumblrApiCall

  def get_details
    blog = 'locapigra'
    key = 'VOf3IKabebfz5hnyCn8dY0JVVX80cqQ1Zc8xzd7TDgOSeCSE51'
    response = HTTParty.get('https://api.tumblr.com/v2/blog/locapigra.tumblr.com/info?api_key=VOf3IKabebfz5hnyCn8dY0JVVX80cqQ1Zc8xzd7TDgOSeCSE51')
    #@json_hash = api_response.parsed_response
    return response.body
  end

end
