module RequestsHelper
  def get_with_token(path, params={}, headers={})
    headers.merge!('HTTP_ACCESS_TOKEN' => retrieve_access_token)
    get path, params, headers
  end

  def post_with_token(path, params={}, headers={})
    headers.merge!('HTTP_ACCESS_TOKEN' => retrieve_access_token)
    post path, params, headers
  end

  def json
    JSON.parse(response.body)
  end

end
