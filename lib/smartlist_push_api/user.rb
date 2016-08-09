module SmartlistPushApi
  class User

    def self.create(data)
      SmartlistPushApi.make_post_request('/users/', data)
    end

    def self.update(user_id, data)
      SmartlistPushApi.make_patch_request("/users/#{user_id}/", data)
    end

    def self.destroy(user_id)
      SmartlistPushApi.make_delete_request("/users/#{user_id}/")
    end

    def self.started_subscription(user_id, plan_name, started_at)
      raise InvalidDataException if plan_name.blank?
      raise InvalidDataException if started_at.blank?

      SmartlistPushApi.make_post_request("/users/#{user_id}/subscription/", {
          type: :signed_up,
          plan_name: plan_name,
          event_at: started_at.utc.strftime('%Y-%m-%d %H:%M:%S')
      })
    end

    def self.canceled_subscription(user_id, plan_name, canceled_at)
      raise InvalidDataException if plan_name.blank?
      raise InvalidDataException if canceled_at.blank?

      SmartlistPushApi.make_post_request("/users/#{user_id}/subscription/", {
          type: :canceled,
          plan_name: plan_name,
          event_at: canceled_at.utc.strftime('%Y-%m-%d %H:%M:%S')
      })
    end

    def self.changed_subscription(user_id, from_plan, to_plan, conversion_at)
      raise InvalidDataException if from_plan.blank?
      raise InvalidDataException if to_plan.blank?
      raise InvalidDataException if conversion_at.blank?

      SmartlistPushApi.make_post_request("/users/#{user_id}/subscription/", {
          type: :conversion,
          plan_name: to_plan,
          from_plan: from_plan,
          event_at: conversion_at.utc.strftime('%Y-%m-%d %H:%M:%S')
      })
    end

    def self.signed_in(user_id, date)
      raise InvalidDataException if date.blank?

      SmartlistPushApi.make_post_request("/users/#{user_id}/login/", {date: date.utc.strftime('%Y-%m-%d %H:%M:%S')})
    end
  end
end