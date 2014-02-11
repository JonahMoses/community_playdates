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

  def self.get_friends(id)
    response = connection.get do |req|
      req.url("/users/#{id}/friends")
    end

    if response.status == 200
      user_params = JSON.parse(response.body)
      user_params.collect do |params|
        User.new(params)
      end
    else
      false
    end
  end

  def self.connection
    Faraday.new(:url => domain) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def self.domain
    if Rails.env.production?
      return "http://communityplaydates.com:3004"
    else
      return "http://localhost:3004"
    end
  end

  def self.get_user(id)
    response = connection.get do |req|
      req.url("/users/#{id}")
    end

    if response.status == 200
      user_params = JSON.parse(response.body)
      User.new(user_params)
    else
      false
    end
  end

end
