class Site < ActiveRecord::Base
  belongs_to :user
  has_many :news
  validates :subdomain, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
