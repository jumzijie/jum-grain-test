# jum-grain-test

This application provides a few endpoints to retrieve orders' data in JSON.

## Table of Contents

+ [APIs](#apis)
+ [Setup](#setup)

## APIs

APIs available:

+ [/orders](#orders) (Retrieving all orders)
+ [/orders/:order_id](#ordersorder_id) (Retrieve specific order)

### /orders

Retrieving all orders, along with their delivery date and time.

Sample response:
```
{
  orders: [
    {
      "order_id": "GO123",
      "delivery_date": "2017-10-20",
      "delivery_time": "11:00–11:30AM"
    },
    {
      "order_id": "GO124",
      "delivery_date": "2017-10-20",
      "delivery_time": "11:00–11:30AM"
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
    "order_id": "GO123",
    "delivery_date": "2017-10-20",
    "delivery_time": "11:00–11:30AM"
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
