require 'test_helper'

module SmartlistPushApi
  class UserTest < Minitest::Test

    def test_create_new_user_is_called
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/', {}])
      SmartlistPushApi.stub(:make_post_request, mock) do
        SmartlistPushApi::User.create({})
      end
      assert mock.verify
    end

    def test_update_user_is_called
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/', {first_name: 'Ivan'}])

      SmartlistPushApi.stub(:make_patch_request, mock) do
        SmartlistPushApi::User.update('user_ref_101', {first_name: 'Ivan'})
      end
      assert mock.verify
    end

    def test_delete_user_is_called
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/'])

      SmartlistPushApi.stub(:make_delete_request, mock) do
        SmartlistPushApi::User.destroy('user_ref_101')
      end
      assert mock.verify
    end

    def test_login_activity_is_called
      date = 1.day.ago.utc
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/login/', {date: date.strftime('%Y-%m-%d %H:%M:%S')}])

      SmartlistPushApi.stub(:make_post_request, mock) do
        SmartlistPushApi::User.signed_in('user_ref_101', date)
      end
      assert mock.verify
    end

    def test_new_subscription_is_called
      date = 1.day.ago.utc
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/subscription/', {
          type: :signed_up,
          plan_name: 'Freemium',
          event_at: date.strftime('%Y-%m-%d %H:%M:%S')
      }])

      SmartlistPushApi.stub(:make_post_request, mock) do
        SmartlistPushApi::User.started_subscription('user_ref_101', 'Freemium', date)
      end
      assert mock.verify
    end

    def test_cancel_subscription_is_called
      date = 1.day.ago.utc
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/subscription/', {
          type: :canceled,
          plan_name: 'Freemium',
          event_at: date.strftime('%Y-%m-%d %H:%M:%S')
      }])

      SmartlistPushApi.stub(:make_post_request, mock) do
        SmartlistPushApi::User.canceled_subscription('user_ref_101', 'Freemium', date)
      end
      assert mock.verify
    end

    def test_subscription_conversion_is_called
      date = 1.day.ago.utc
      mock = MiniTest::Mock.new
      mock.expect(:call, true, ['/users/user_ref_101/subscription/', {
          type: :conversion,
          plan_name: 'Pro',
          from_plan: 'Freemium',
          event_at: date.strftime('%Y-%m-%d %H:%M:%S')
      }])

      SmartlistPushApi.stub(:make_post_request, mock) do
        SmartlistPushApi::User.changed_subscription('user_ref_101', 'Freemium', 'Pro', date)
      end
      assert mock.verify
    end

  end
end
