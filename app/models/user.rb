class User
  include MongoMapper::Document

  key :firstname, String
  key :lastname, String
  key :age, Integer

end
