class Search
  include Mongoid::Document
  belongs_to :url
  field :keyword, type: String 
  field :count, type: Integer
  field :description, type: String
end
