class UserClient

  def self.login(auth)
    response = connection.post do |req|
      req.url('/users')
      req.headers['Content-Type'] = 'application/json'
      req.body = auth.to_json
    end

    if response.status == 201
      user_params = JSON.parse(response.body)
      User.new(user_params)
    else
      false
    end

  end

  def self.connection
    Faraday.new(:url => 'http://localhost:3004') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def self.find

  end

end
