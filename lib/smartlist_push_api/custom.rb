module SmartlistPushApi
  class Custom

    def self.create(user_id, data)
      SmartlistPushApi.make_post_request('/custom/', {id: user_id}.merge(data))
    end

  end
end