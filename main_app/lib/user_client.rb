class UserClient

  def self.login(auth)
    response = connection.post do |req|
      req.url("/users?auth_id=#{ENV['APP_CONFIRMATION']}")
      req.headers['Content-Type'] = 'application/json'
      req.body = auth.to_json
    end

    if response.status == 201
      user_params = JSON.parse(response.body)
      user = User.new(user_params)
      user.friends = user.friends.collect do |f|
        User.new(f)
      end
      user
    else
      false
    end
  end

  def self.get_friends(id)
    response = connection.get do |req|
      req.url("/users/#{id}/friends?auth_id=#{ENV['APP_CONFIRMATION']}")
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
      req.url("/users/#{id}?auth_id=#{ENV['APP_CONFIRMATION']}")
    end

    if response.status == 200
      user_params = JSON.parse(response.body)
      User.new(user_params)
    else
      false
    end
  end

  def self.get_all_friend_data(id)
    response = connection.get do |req|
      req.url("/users/#{id}/all-friend-data?auth_id=#{ENV['APP_CONFIRMATION']}")
    end

    if response.status == 200
      # return response
      user_params = JSON.parse(response.body)
      package = {}
      user = User.new(user_params["user"])
      user.friends = user_params["friends"].collect do |f|
        User.new(f)
      end
      user_params["friends_of_friends"].each do |n|
        user.friends_of_friends += n.collect {|data| User.new(data)}
      end.flatten!
      user
    else
      false
    end
  end

end
