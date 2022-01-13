# README

This is an API used to find the cost of items in a store given a few discounts.

## Installation

To install this repository please do the following:

  1. `git clone git@github.com:iferunsewe/store_api.git`
  2. `cd store_api`
  3. `bundle install` (this will install all the dependencies)
  4. `bundle rake db:create db:migrate db:seed` (this will create the database, run migrations and seed relevant data)
  
*Note there are some items, discounts and quotes seeded when yoo run `rake db:seed`. The respective records can be found in `db/seeds.rb`.

## Usage

In order to use the API locally, please do the following from your local pokemon_api respository:

  1. bundle exec rails s -p 3000(this will start a local server for you)
  2. Make requests to the following endpoints from `http://localhost:3000`:

  
  ### Endpoints

  #### Items

  *GET /items* - All the existing items in the store, as well as their attributes.
  
  Example response
  ```
  { 
    [
      {"code":"MUG","name":"Reedsy Mug","price":"6.0€"},
      {"code":"TSHIRT","name":"Reedsy T-shirt","price":"15.0€"},
      {"code":"HOODIE","name":"Reedsy Hoodie","price":"20.0€"}
    ]
  }
  ```

  *PUT /items* - Update the price of a given item.

  Example request parameters
  ```
  {
    item: {
      price: 750
    }
  }
  ```

  Example response
  ```
  {
    {
      "code":"MUG",
      "name":"Reedsy Mug",
      "price":"7.50€"
    },
  }
  ```

  #### Quotes

  *POST /quotes* - Create a quote and get the price of items.
  
  Example request parameters
  ```
  { 
    "item_codes":["ITEM-1", "ITEM-2"]
  }
  ```

  Example response
  ```
  {
    {
      "item_codes": ["ITEM-1", "ITEM-2"], 
      "total"=> "30.00€"
    },
  }
  ```
  *Note in this example 'ITEM-1' and 'ITEM-2' are codes of items that have been created prior to retrieving a quote
  
  ### Table

  #### Items

    | Column | Type    |
    | ------ | ------- |
    | code   | string  |
    | name   | string  |
    | price  | integer |

  #### Quotes

    | Column     | Type    |
    | ---------- | ------- |
    | total      | integer |
    | subtotal   | integer |
    | item_codes | array   |

  #### Discounts

    | Column              | Type    |
    | ------------------- | ------- |
    | discount_type       | integer |
    | code                | string  |
    | min_quantity        | integer |
    | discount_percentage | integer |

  *Note the discount_type can only be chosen from two different types at the moment 'bundle' and 'percentage'. See 'app/models/discount.rb' to check what each discount does.

  `bundle exec rails console` - run this from the root of your directory and you can create a record in any of these tables e.g. `Item.create({ code: 'MUG', name: 'Reedsy Mug', price: 600 })`.

## Testing

To run the tests for this project, please run the following from your local pokemon_api respository:

  `bundle exec rspec`