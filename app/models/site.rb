class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subdomain, use: :slugged
  belongs_to :user
  has_many :posts
  has_many :members
  validates :subdomain, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
