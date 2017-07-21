class Image < ActiveRecord::Base
  validates :title, :size, :filename, presence: true
  validates :title, uniqueness: true
end
