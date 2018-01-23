# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# clear db first, reset id to start from 1
ActiveRecord::Base.establish_connection
table_names = "delivery_orders, meals, order_items"
ActiveRecord::Base.connection.execute("TRUNCATE #{table_names}")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_names} RESTART IDENTITY")

# create 10 meals
Meal.create(name: "A partridge in a pear tree", byline: "one")
Meal.create(name: "Two turtle doves", byline: "two")
Meal.create(name: "Three french hens", byline: "three")
Meal.create(name: "Four calling birds", byline: "four")
Meal.create(name: "Five golden rings", byline: "five")
Meal.create(name: "Six geese a laying", byline: "six")
Meal.create(name: "Seven swans a swimming", byline: "seven")
Meal.create(name: "Eight maids a milking", byline: "eight")
Meal.create(name: "Nine ladies dancing", byline: "nine")
Meal.create(name: "Ten lords a leaping", byline: "ten")

# create 5 delivery orders that contains any number of order items ranging from 1 to 5
serving_datetime = Time.zone.now.beginning_of_day + 11.hours # 11am
5.times do |i|
  # create 1 delivery each for the next 5 days
  serving_datetime += 1.day
  delivery_order = DeliveryOrder.create(serving_datetime: serving_datetime)

  # create random number of order items ranging from 1 to 5
  num_order_items = rand(1..5)
  # keep track of selected meals, so don't repeat again
  selected_meal_ids = []
  num_order_items.times do |j|
    # random a meal that has not been selected yet
    meal = Meal.where.not(id: selected_meal_ids).sample
    selected_meal_ids.push(meal.id)

    order_item = OrderItem.new
    order_item.delivery_order = delivery_order
    order_item.meal = meal
    order_item.serving_date = delivery_order.serving_datetime
    order_item.quantity = [1,1,1,2].sample # random between 1 or 2, with a higher chance for 1
    order_item.unit_price = 800
    order_item.save
  end
end
