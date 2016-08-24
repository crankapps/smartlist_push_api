# Smartlist Push API

THe Smartlist Push API allows you to send your user activity to Smartlist to drive analytics and automated messaging through the Smartlist application. The data that you send to Smartlist  is used to set up filters that enable the creation of segments and targeting for automated messaging to users.

## Installation

To get started, add this line to your application's Gemfile:

```ruby 
    gem 'smartlist_push_api'
```

And then execute:

```
   $ bundle
```

Or install it yourself as:

```
   $ gem install smartlist_push_api
```

## Enabling Push API

First, you will need an account at [Smartlist](http://smartlisthq.com). After you create an account, you can enable the Push API from your [profile settings](http://smartlisthq.com/app/profile/push-api) where you can get an access token.

Create initializer `smartlist_push_api.rb` and put

```ruby   
    SmartlistPushApi.access_token = 'your-access-token'
```

## Usage

#### User Account

Once a user registers within your app, you can send that information to Smartlist via the following:

```ruby  
    SmartlistPushApi::User.create({
     email: 'user@example.com',              # required
     ref_id: 'ref_user_102',                 # required
     first_name: 'John',                     # optional
     last_name: 'Doe',                       # optional
     display_name: 'John Doe',               # optional
     company_name: 'ABC Corp',               # optional
     ref_created_at: '2016-07-26 20:28:37',  # required
     ref_updated_at: '2016-07-27 18:08:37'   # required
    })
```

The field `ref_id` is required and should be unique for each user from your app. You will use that field to create or update a user’s information.  

You can also use the above method to deliver your existing users data to Smartlist.

When a user changes their data, you can sync information with Smartlist with the following method:

```ruby 
    SmartlistPushApi::User.update('ref_user_102', {first_name: 'Joana'})
```

The first attribute is a `ref_id` and the second attribute is the object that has any of the previously mentioned user attributes, as well as the attribute `unsubscribed`. Setting `unsubscribed` to false will prevent this user from receiving emails. If user leaves your app, you should remove them from Smartlist with the following:

```ruby 
    SmartlistPushApi::User.destroy('ref_user_102')
```
The above method will remove user who has `ref_id` set to `ref_user_102` from Smartlist.


#### Login Activity

Every time user logs in in your app, you can update Smartlist (as a way to track user activity):

```ruby 
    SmartlistPushApi::User.signed_in('ref_user_102', Time.current)
```
This method receive two attributes: user's `ref_id` and a `datetime` object. 

You can also use the above method to deliver your existing users login activity to Smartlist.

#### Subscription Activity

If your app has subscription plans, you can send that to Smartlist to filter users by subscription type.. In addition, we recognize four different subscription event types: **signed_up**, **canceled**, **upgraded** and **downgraded**.

- **signed_up** should be sent when user start using a plan for the first time (after first registering with your app);
- **canceled** should be sent when user cancels a plan;
- **upgraded** when user upgrades to a higher plan;
- **downgrade** when user downgrades to a lower plan.

```ruby
 # ref_id, plan name, datetime object when subscription started
 SmartlistPushApi::User.started_subscription('ref_user_102', 'Freemium', 1.week.ago)
 # ref_id, from plan name, to plan name, datetime object when subscription was upgraded
 SmartlistPushApi::User.upgraded_subscription('ref_user_102', 'Freemium', 'Pro', 1.week.ago)
 # ref_id, from plan name, to plan name, datetime object when subscription was downgraded
 SmartlistPushApi::User.downgraded_subscription('ref_user_102', 'Pro', 'Freemium', 2.days.ago)
 # ref_id, plan name that was canceled, datetime object when subscription was cancelled
 SmartlistPushApi::User.canceled_subscription('ref_user_102', 'Pro', 2.days.ago)
```
You can also use the above method to deliver your existing users subscription status to Smartlist.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
