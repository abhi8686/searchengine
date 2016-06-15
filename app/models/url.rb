class Url
  include Mongoid::Document
  has_many :searchs
  field :url, type: String
  field :title, type: String
 	field :description, type: String

  index({ url: 1 }, { unique: true, name: "url_index" })
end
