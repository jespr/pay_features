# PayFeatures

PayFeatures is a gem to add `plan` features to your subscription plan. Let's say a user is subscribed to the Simple plan, which allows for 2 team_members. You can easily set up features and checks to use in your app and to display on your pricing page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pay_features'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install pay_features
```

## Migrations

Install migrations by running

```bash
rails pay_features:install:migrations
```

That will add two new tables as well as add `previous_plan_id` to your existing `plans` table.

## Usage

Per default we rely on an existing `plans` table to be present. This is only needed if you want the feature inheritance between plans.

In your existing `plan` model, add the following:

```ruby
class Plan < ActiveModel
  include PayFeatures::Plan
end
```

You can then set up features and your plans like this:

```ruby
first_plan = Plan.create(name: "First plan")
second_plan = Plan.create(name: "Second plan", previous_plan: first_plan)

first_plan.features.create(identifier: "users", amount: 2)
first_plan.features.create(identifier: "can_create_teams", description: "Can create teams")
second_plan.features.create(identifier: "users", amount: 10)
second_plan.features.create(identifier: "api_access", description: "Use the API")
```

You can perform simple checks like this:

```ruby
first_plan.has_feature?(:users)
# => true

first_plan.amount_for(:users)
# => 2

# Features are inherited when previous_plan is set
second_plan.has_feature?(:can_create_teams)
# => true

first_plan.has_feature?(:api_access)
# => false

second_plan.has_feature?(:api_access)
# => true
```

If you want to display the features on your pricing page, you can access `plan.display_features` which will give you an array similar to this:

```ruby
{
  identifier: "users",
  description: "2 users",
  amount: 2,
}
```

If a feature exists on the previous plan, and you add it to the plan after similar to this:

```ruby
first_plan = Plan.create(name: "First plan")
second_plan = Plan.create(name: "Second plan", previous_plan: first_plan)

first_plan.features.create(identifier: "users", amount: 2, description: "2 users")
second_plan.features.create(identifier: "users", amount: 10, description: "10 users")
second_plan.features.create(identifier: "api_access", description: "API Access")
```

If you call `second_plan.display_features` you'll see the `users` feature marked as a new feature. This is so you can highlight differences in your pricing table.

```ruby
[
  {
    identifier: "users",
    description: "10 users",
    amount: 10,
    new_feature: true,
  },
  {
    identifier: "api_access",
    description: "API Access",
    amount: nil,
    new_feature: true,
  },
]
```

## Contributing

Open up Issue/PR if you encounter any problems or have ideas.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
