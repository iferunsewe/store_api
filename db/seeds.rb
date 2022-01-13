# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Item.create({ code: 'MUG', name: 'Reedsy Mug', price: 600 })
Item.create({ code: 'TSHIRT', name: 'Reedsy T-shirt', price: 1500 })
Item.create({ code: 'HOODIE', name: 'Reedsy Hoodie', price: 2000 })

Discount.create({ discount_type: 'bundle', code: 'MUG', min_quantity: 2, discount_percentage: 0 })
Discount.create({ discount_type: 'percentage', code: 'TSHIRT', min_quantity: 3, discount_percentage: 30 })

Quote.create({ item_codes: ['MUG', 'TSHIRT', 'HOODIE'] })
Quote.create({ item_codes: ['MUG', 'TSHIRT', 'MUG'] })
Quote.create({ item_codes: ['MUG', 'TSHIRT', 'MUG', 'MUG'] })
Quote.create({ item_codes: ['MUG', 'TSHIRT', 'MUG', 'MUG', 'MUG'] })
Quote.create({ item_codes: ['MUG', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'MUG', 'HOODIE'] })
