class User < ActiveRecord::Base
  validates_presence_of :username, :password

  validates :username, { uniqueness: {message: "That username is taken. Please enter another."}}

  validates :password, {confirmation: true}
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
    do_not_validate_attachment_file_type :avatar
end
