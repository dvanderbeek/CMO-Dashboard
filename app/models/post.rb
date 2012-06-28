class Post < ActiveRecord::Base
  belongs_to :site
  has_attached_file :document,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  has_attached_file :photo,
    :styles => { :large => "600x", :medium => "300x", :thumb => "100x" }
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  scope :document, :conditions => "post_type = 'Document'"
  scope :photo, :conditions => "post_type = 'Photo'"
  scope :news, :conditions => "post_type = 'News'"
  validates :title, :presence => true

  def self.search(search)
    if search
      where('UPPER(title) LIKE ? OR UPPER(content) LIKE ? OR UPPER(post_type) LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
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
