class Post < ActiveRecord::Base
  # Post belongs to user, comments are dependent on post
  belongs_to :user
  has_many :comments, dependent: :destroy

  # define Paperclip image sizes and default, validate for image attachment, allow pngs and jpegs
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "coffee_clock_small.jpg",
    :url => ":s3_domain_url",
    :path => "public/avatars/:id/:style_:basename.:extension",
    :storage => :fog,
    :fog_credentials => {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      access_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    },
    fog_directory: ENV["FOG_DIRECTORY"]
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
    do_not_validate_attachment_file_type :avatar
end
