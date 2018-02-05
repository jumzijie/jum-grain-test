# jum-grain-test

This application uses Vue JS to provide a page to submit feedback for the orders made. It also provides a few endpoints to retrieve orders and feedbacks data in JSON.

## Table of Contents

+ [APIs](#apis)
+ [Setup](#setup)

## APIs

APIs available:

+ [/orders](#orders) (Retrieving all orders)
+ [/orders/:order_id](#ordersorder_id) (Retrieve specific order)
+ [/orders/:order_id/feedbacks](#ordersorder_idfeedbacks) (Retrieve feedbacks of specific order)
+ [/orders/:order_id/feedbacks (POST)](#ordersorder_idfeedbacks-post) (Submit feedbacks of specific order)

### /orders

Retrieving all orders, along with their delivery date and time.

Sample response:
```
{
  orders: [
    {
      "id": 123,
      "order_id": "GO123",
      "delivery_date": "2017-10-20",
      "delivery_time": "11:00–11:30AM",
      "feedback_submitted": false,
      "order_items": [
        {
          "order_item_id": 1,
          "name": "Buffalo Chicken on Sweet Potato Mash and Celery Confit"
        },
        {
          "order_item_id": 2,
          "name": "Chocolate Banana Crumble Tart with praline & caramel sauce"
        }
      ]
    },
    {
      "id": 124,
      "order_id": "GO124",
      "delivery_date": "2017-10-20",
      "delivery_time": "11:00–11:30AM",
      "feedback_submitted": true,
        "order_items": [
        {
          "order_item_id": 1,
          "name": "Buffalo Chicken on Sweet Potato Mash and Celery Confit"
        },
        {
          "order_item_id": 2,
          "name": "Chocolate Banana Crumble Tart with praline & caramel sauce"
        }
      ]
    }
  ]
}

```

### /orders/:order_id

Retrieving specific order, along with its delivery date and time, and the meals associated, with their name, quantity, and total price.

Sample response:
```
{
  order: {
    "id": 123,
    "order_id": "GO123",
    "delivery_date": "2017-10-20",
    "delivery_time": "11:00–11:30AM",
    "feedback_submitted": false,
    "order_items": [
      {
        "name": "Buffalo Chicken on Sweet Potato Mash and Celery Confit ",
        "quantity": 2,
        "total_price": 2390
      }
    ]
  }
}
```

### /orders/:order_id/feedbacks

Retrieving feedbacks of specific order for both delivery order and the meals.

Sample response:
```
{
  "feedbacks": [
    {
      "ratable_id": 123,
      "ratable_type": "DeliveryOrder",
      "rating": 1,
      "comment": "Delivery was prompt and rider was kind, but he forgot cutleries"
    },
    {
      "ratable_id": 1,
      "ratable_type": "OrderItem",
      "rating": -1,
      "comment": "The food portion was too little, was alittle hungry after"
    }
    {
      "ratable_id": 2,
      "ratable_type": "OrderItem",
      "rating": 1,
      "comment": "It was super tasty and I loved it"
    }
  ]
}
```

### /orders/:order_id/feedbacks (POST)

Submitting feedbacks of specific order.

Sample payload:
```
{
  feedbacks: [
    {
      "ratable_id": 123,
      "ratable_type": "DeliveryOrder",
      "rating": 1,
      "comment": "Delivery was prompt and rider was kind, but he forgot cutleries"
    },
    {
      "ratable_id": 1,
      "ratable_type": "OrderItem",
      "rating": -1,
      "comment": "The food portion was too little, was alittle hungry after"
    }
    {
      "ratable_id": 2,
      "ratable_type": "OrderItem",
      "rating": 1,
      "comment": "It was super tasty and I loved it"
    }
  ]
}
```

Sample response:
```
{
  status: "OK"
}
```

## Setup

I'm using a Windows 10 machine, so all my setup details are for Windows.

Requirements:
+ [Ruby on Rails 5](http://www.railsinstaller.org/en)
+ [PostgreSQL](https://www.postgresql.org/download/)

To setup:
```sh
git clone https://github.com/jumzijie/jum-grain-test.git
```

Go into the newly cloned folder:
```
cd jum-grain-test
```

Run bundle:
```
bundle install --without production
```

Start PostgreSQL (replace <YOUR_USERNAME> with your username):
```
pg_ctl -D 'C:\Users\<YOUR_USERNAME>\AppData\PostgreSQL' start
```

Create new database:
```
createdb grain_development
```

Reset database:
```
rails db:reset
```

Run rails:
```
rails s
```
