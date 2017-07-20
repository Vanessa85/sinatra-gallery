class Image < ActiveRecord::Base
  validates :filename, :size, :url, presence: true
  validates :filename, uniqueness: true
end
