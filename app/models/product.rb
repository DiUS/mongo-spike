class Product
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :price, Float
  key :quantity, Integer
end
