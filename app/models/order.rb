class Order
  include MongoMapper::Document

  key :customer
  many :products
end
