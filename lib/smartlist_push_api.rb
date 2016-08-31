require 'smartlist_push_api/version'
require 'smartlist_push_api/http/http_client'
require 'smartlist_push_api/user'
require 'smartlist_push_api/custom'

module SmartlistPushApi
  class InvalidDataException < StandardError;
  end

  @base_uri = 'http://smartlisthq.com/push'
  @access_token = ''

  class << self
    attr_accessor :base_uri, :access_token
  end

  def self.make_post_request(url, data)
    SmartlistPushApi.make_request(:POST, url, data)
  end

  def self.make_patch_request(url, data)
    SmartlistPushApi.make_request(:PATCH, url, data)
  end

  def self.make_get_request(url)
    SmartlistPushApi.make_request(:GET, url)
  end

  def self.make_delete_request(url)
    SmartlistPushApi.make_request(:GET, url)
  end

  def self.make_request(request_method, url, data = nil)

    http_client = Http::HttpClient.new
    if request_method == :POST
      raise InvalidDataException if data.nil?

      response = http_client.post_request(url, data)
      return response.code == 200
    elsif request_method == :PATCH
      raise InvalidDataException if data.nil?

      response = http_client.patch_request(url, data)
      return response.code == 200
    elsif request_method == :GET
      response = http_client.get_request(url)
      return response.code == 200
    elsif request_method == :DELETE
      response = http_client.delete_request(url)
      return response.code == 204
    end

    return false
  rescue => e
    return false
  end

end
