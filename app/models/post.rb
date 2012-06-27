class Post < ActiveRecord::Base
  belongs_to :site
  has_attached_file :document
  has_attached_file :photo, :styles => { :large => "600x", :medium => "300x", :thumb => "100x" }
  scope :document, :conditions => "post_type = 'Document'"
  scope :photo, :conditions => "post_type = 'Photo'"
  scope :news, :conditions => "post_type = 'News'"
  validates :title, :presence => true

  def self.search(search)
    if search
      where('title LIKE ? OR content LIKE ? OR post_type LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def self.filter_site(site)
    if site
      where('site_id = ?', site)
    else
      scoped
    end
  end

  def self.filter_post_type(post_type)
    if post_type
      where('post_type = ?', post_type)
    else
      scoped
    end
  end

end
